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
    :url

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
  end

  # def ticket_description
  #   <<-EOF
  #   ## Summary

  #   Original ticket:  [PT#{id}](#{url})
  #   Title: #{title}

  #   Created at: #{created_at}
  #   Accepted at: #{accepted_at}
  #   Deadline: #{deadline}
  #   Requested by: #{requested_by}
  #   Type: #{type}
  #   Estimate: #{estimate}
  #   Current State: #{current_state}

  #   Iteration: #{iteration}
  #   Iteration start: #{iteration_start}
  #   Iteration end: #{iteration_end}

  #   ## Description

  #   EOF
  #     .gsub(/^    /, '') + description
  # end
end

