require 'pt/story'

RSpec.describe 'PT::Story class' do

  before {
    @csv = PT2GHHelper::CsvData.new().csv_data
  }


  def check_story_basics(row)
    story = PT::Story.new(row)
    expect(story).to be_a(PT::Story)
    expect(story.id).to eq(row["Id"])
    expect(story.title).to eq(row["Title"])
    expect(story.iteration).to eq(row["Iteration"])
    expect(story.iteration_start).to eq(row["Iteration Start"])
    expect(story.iteration_end).to eq(row["Iteration End"])
    expect(story.type).to eq(row["Type"])
    expect(story.estimate).to eq(row["Estimate"])
    expect(story.current_state).to eq(row["Current State"])
    expect(story.created_at).to eq(row["Created at"])
    expect(story.accepted_at).to eq(row["Accepted at"])
    expect(story.deadline).to eq(row["Deadline"])
    expect(story.requested_by).to eq(row["Requested By"])
    expect(story.description).to eq(row["Description"])
    expect(story.url).to eq(row["URL"])
    story
  end

  def dump_description(s)
    # puts "\n\n#{s.ticket_description}\n\n"
  end


  it 'can be constructed, part 1' do
    s = check_story_basics(@csv[0])
    dump_description(s)
  end

  it 'can be constructed, part 2' do
    s = check_story_basics(@csv[1])
    dump_description(s)
  end

end
