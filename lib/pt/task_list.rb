require_relative 'task'


module PT; end
class PT::TaskList
  attr_reader :tasks

  def initialize(row)
    parse_row(row)
  end

  def to_markdown
    if @tasks.length
      @tasks
        .map { |t| t.to_markdown }
        .join("\n")
    else
      nil
    end
  end

  def body
    md = to_markdown
    {:body => md} if md
  end

  def post(path, issue_number)
    b = JSON.generate(body)
    GitHub.post("/repos/#{path}/#{issue_number}/comments", b) if b
  end

  private

  def parse_row(row)
    if @tasks.nil?
      @tasks = []
      task = nil
      row.each do |f|
        task = case f[0]
               when 'Blocker'
                 (f[1] && f[1] != '') ? PT::Task.new(f[1], true) : nil
               when 'Blocker Status'
                 if task
                   task.status = f[1]
                   @tasks.push(task)
                 end
                 nil
               when 'Task'
                 (f[1] && f[1] != '') ? PT::Task.new(f[1], false) : nil
               when 'Task Status'
                 if task
                   task.status = f[1]
                   @tasks.push(task)
                 end
                 nil
               else nil
               end
      end
    end
    @tasks
  end
end
