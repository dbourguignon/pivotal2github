require 'csv'

module PT2GHHelper
  class CsvData

    MAX_OWNER_COUNT       = 4
    MAX_BLOCKER_COUNT     = 4
    MAX_COMMENT_COUNT     = 4
    MAX_TASK_COUNT        = 4
    DEFAULT_CREATION_DATE = 'Feb 1, 2015'
    DEFAULT_REQUESTER     = 'Prod Manager'

    attr_reader :csv_data

    def initialize()
      @csv_string = CSV.generate do |csv|
        csv << self.class.headers
        csv << row_01
      end
      @csv_data = CSV.parse(@csv_string, headers: true)
    end

    def row_01
      create_row(
        12345,
        'Story 1',
        labels: 'junk,test',
        description: "A description goes here.\n\nSee comments."
      )
    end

    def row_02
      create_row(
        12346,
        'Story 2',
        created_at: 'Aug 12, 2015',
        description: "A different description"
      )
    end

    def create_row(
      id,
      title,
      labels: nil,
      iteration: nil,
      iteration_start: nil,
      iteration_end: nil,
      type: 'feature',
      estimate: nil,
      current_state: 'unscheduled',
      created_at: DEFAULT_CREATION_DATE,
      accepted_at: nil,
      deadline: nil,
      requested_by: 'Prod Manager',
      description: '',
      owners: [],
      blockers: [],
      comments: [],
      tasks: []
    )
      id    || raise('Must provide an ID number')
      title || raise('Must provide a title')

      row = [
        id,
        title,
        labels,
        iteration,
        iteration_start,
        iteration_end,
        type,
        estimate,
        current_state,
        created_at,
        accepted_at,
        deadline,
        requested_by,
        description,
        create_url(id)
      ]

      row += check_owners(owners)
      row += check_blockers(blockers)
      row += check_comments(comments)
      row += check_tasks(tasks)
    end



    def self.headers
      [
        'Id',               #   0 
        'Title',            #   1 
        'Labels',           #   2 
        'Iteration',        #   3 
        'Iteration Start',  #   4 
        'Iteration End',    #   5 
        'Type',             #   6 
        'Estimate',         #   7 
        'Current State',    #   8 
        'Created at',       #   9 
        'Accepted at',      #  10
        'Deadline',         #  11
        'Requested By',     #  12
        'Description',      #  13
        'URL',              #  14
        'Owned By',         #  15
        'Owned By',         #  16
        'Owned By',         #  17
        'Owned By',         #  18
        'Blocker',          #  19
        'Blocker Status',   #  20
        'Blocker',          #  21
        'Blocker Status',   #  22
        'Blocker',          #  23
        'Blocker Status',   #  24
        'Blocker',          #  25
        'Blocker Status',   #  26
        'Comment',          #  27
        'Comment',          #  28
        'Comment',          #  29
        'Comment',          #  30
        'Task',             #  31
        'Task Status',      #  32
        'Task',             #  33
        'Task Status',      #  34
        'Task',             #  35
        'Task Status',      #  36
        'Task',             #  37
        'Task Status'       #  38
      ]
    end


    private


    def create_url(id)
      "https://www.pivotaltracker.com/story/show/#{id}"
    end


    def check_multi(values, max, default = nil)
      values ||= []
      while values.length < max
        values << default
      end
      values
    end

    def check_owners(values = [])
      check_multi(values, MAX_OWNER_COUNT)
    end

    def check_comments(values = [])
      check_multi(values, MAX_COMMENT_COUNT)
    end

    def check_blockers(values = [])
      blockers = check_multi(values, MAX_BLOCKER_COUNT, [nil, nil])
      blockers.map do |t|
        t = [t, nil] unless t.is_a? Array
        t.push(nil) unless t.length > 1
        if t.length > 2
          raise "Blocker must be an array of length 2:  #{t.inspect}"
        end
      end
      blockers.flatten
    end

    def check_tasks(values = [])
      tasks = check_multi(values, MAX_TASK_COUNT, [nil, nil])
      tasks.map do |t|
        t = [t, nil] unless t.is_a? Array
        t.push(nil) unless t.length > 1
        if t.length > 2
          raise "Task must be an array of length 2:  #{t.inspect}"
        end
      end
      tasks.flatten
    end

  end
end
