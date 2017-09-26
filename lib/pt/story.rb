require_relative 'label_list'
require_relative 'owner_list'
require_relative 'task_list'


# Handles columns:
#   - "Id"
#   - "Title"
#   - "Iteration"
#   - "Iteration Start"
#   - "Iteration End"
#   - "Type"
#   - "Estimate"
#   - "Current State"
#   - "Created at"
#   - "Accepted at"
#   - "Deadline"
#   - "Requested By"
#   - "Description"
#   - "URL"


module PT; end
class PT::Story

  attr_reader \
    :github_id,
    :id,
    :title,
    :iteration,
    :iteration_start,
    :iteration_end,
    :type,
    :estimate,
    :current_state,
    :created_at,
    :accepted_at,
    :deadline,
    :requested_by,
    :description,
    :url,
    :label_list,
    :owner_list,
    :task_list

  def initialize(row)
    @id              = row["Id"]
    @title           = row["Title"]
    @iteration       = row["Iteration"]
    @iteration_start = row["Iteration Start"]
    @iteration_end   = row["Iteration End"]
    @type            = row["Type"]
    @estimate        = row["Estimate"]
    @current_state   = row["Current State"]
    @created_at      = row["Created at"]
    @accepted_at     = row["Accepted at"]
    @deadline        = row["Deadline"]
    @requested_by    = row["Requested By"]
    @description     = row["Description"]
    @url             = row["URL"]
    # @label_list      = PT::LabelList.new(row)
    # @owner_list      = PT::OwnerList.new(row)
    # @task_list       = PT::TaskList.new(row)
  end

  def ticket_description
    <<-EOF
    Pivotal Tracker Ticket: [PT#{id}](#{url})
    Title: #{title}

    ## Summary

    Created at: #{maybe_field created_at}
    Accepted at: #{maybe_field accepted_at}
    Deadline: #{maybe_field deadline}
    Requested by: #{maybe_field requested_by}
    Type: #{type}
    Estimate: #{maybe_field estimate}
    Current State: #{maybe_field current_state}

    Iteration: #{maybe_field iteration}
    Iteration start: #{maybe_field iteration_start}
    Iteration end: #{maybe_field iteration_end}

    ## Description

    EOF
      .gsub(/^    /, '') + description
  end

  private

  def maybe_field(value)
    if value && value.strip != ''
      value
    else
      "N/A"
    end
  end

  def maybe_list(values)
    vs = values || []
    if vs.length > 0
      "\n  - " + vs.join("\n  - ")
    else
      "_None_"
    end
  end
end

