require 'pt/story'

RSpec.describe 'PT::Story class' do

  before {
    @csv_data = PT2GHHelper::CsvData.new().csv_data
  }


  def check_story_basics(row_idx)
    @exp_md  = PT2GHHelper::ExpectedMarkdown.new(row_idx)
    @csv_row = @csv_data[row_idx]
    @story   = PT::Story.new(@csv_row)
    expect(@story).to be_a(PT::Story)
    expect(@story.id).to eq(@csv_row["Id"])
    expect(@story.title).to eq(@csv_row["Title"])
    expect(@story.iteration).to eq(@csv_row["Iteration"])
    expect(@story.iteration_start).to eq(@csv_row["Iteration Start"])
    expect(@story.iteration_end).to eq(@csv_row["Iteration End"])
    expect(@story.type).to eq(@csv_row["Type"])
    expect(@story.estimate).to eq(@csv_row["Estimate"])
    expect(@story.current_state).to eq(@csv_row["Current State"])
    expect(@story.created_at).to eq(@csv_row["Created at"])
    expect(@story.accepted_at).to eq(@csv_row["Accepted at"])
    expect(@story.deadline).to eq(@csv_row["Deadline"])
    expect(@story.requested_by).to eq(@csv_row["Requested By"])
    expect(@story.description).to eq(@csv_row["Description"])
    expect(@story.url).to eq(@csv_row["URL"])
    @story
  end

  def dump_description(s)
    # puts "\n\n#{s.ticket_description}\n\n"
  end


  it 'can be constructed, part 1' do
    s = check_story_basics(0)
    dump_description(s)
  end

  it 'can be constructed, part 2' do
    s = check_story_basics(1)
    dump_description(s)
  end

end
