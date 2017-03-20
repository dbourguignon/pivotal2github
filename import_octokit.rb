#encoding:UTF-8
#!/usr/bin/env ruby
require 'OctoKit'
require 'CSV'
require 'highline/import'
require 'yaml'

# because github didn't display my random colors
ISSUE_COLORS = ['d4c5f9','e11d21','eb6420','fbca04','009800','006b75','207de5',
				'0052cc','5319e7','f7c6c7','fad8c7','fef2c0','bfe5bf','bfdadc',
				'c7def8', 'bfd4f2']

def get_input(prompt="Enter >",show = true)
	ask(prompt) {|q| q.echo = show}
end

issues_csv = ARGV.shift or raise "Enter Filepath to CSV as ARG1"

credentials = YAML.load_file('login.yaml') if File.exists?('login.yaml')

user = credentials.nil? ? get_input('Enter Username >') : credentials['USERNAME']
password = credentials.nil? ? get_input('Enter Password >', '*') : credentials['PASSWORD']

client = Octokit::Client.new \
	:login => user,
	:password => password

user = client.user
user.login

repo = get_input('Enter repo (owner/repo_name) >')

Issue = Struct.new(:title, :body, :labels, :comments, :tasks)
Task = Struct.new(:desc, :status)
issues = Array.new

CSV.foreach issues_csv, headers: true do |row|
  labels = [row['Type']]
  labels << row['Labels'].split(',') unless row['Labels'].nil?
  # lol let's hack around the duplicate column names from pivotal tracker
  comments_col = row.index('Comment')
  has_comments = !comments_col.nil?
  comments = []
  while has_comments do
    comments << row['Comment', comments_col]
    comments_col += 1
    has_comments = !row['Comment', comments_col].nil?
  end

  task_col = row.index('Task')
  has_tasks = !task_col.nil?
  tasks = []
  while has_tasks do
    status = row['Task Status', task_col].eql?('not complete') ? 'x' : ' '
    tasks << Task.new(row['Task', task_col], status)
    task_col += 2 # accommodate 'Task Status'
    has_tasks = !row['Task', task_col].nil?
  end

  issues << Issue.new(row['Title'], row['Description'], labels, comments, tasks)
end
unique_labels = issues.map{ |i| i.labels }.flatten.map{|j| j.strip unless j.nil?}.uniq
puts "adding labels: #{unique_labels.to_s}"
unique_labels.each do |l|
  begin
    client.add_label(repo, l, ISSUE_COLORS.sample) unless l.nil?
  rescue Octokit::UnprocessableEntity => e
    puts "Unable to add #{l} as a label. Reason: #{e.errors.first[:code]}"
  end
end

issues.each do |issue|
  puts "creating issue '#{issue.title}'"
  issue.tasks.each do |task|
    issue.body << "\n - [#{task.status}] #{task.desc}"
  end
  
  issue_number = client.create_issue(repo, issue.title, issue.body, {:labels => issue.labels.join(',')}).number
  issue.comments.each do |comment|
    puts "add comment #{comment}"
    client.add_comment(repo, issue_number, comment)
  end
end
