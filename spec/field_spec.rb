require 'pt/field'

RSpec.describe 'PT::Field class' do

  it 'can be constructed, part 1' do
    t = PT::Field.new('a task')
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
  end

  it 'can be constructed, part 2' do
    t = PT::Field.new('another task')
    expect(t).to_not be_nil
    expect(t.text).to eq('another task')
  end

  it 'can generate markdown, part 1' do
    t = PT::Field.new('a task')
    expect(t).to_not be_nil
    expect(t.to_markdown).to eq('- a task')
  end

  it 'can generate markdown, part 2' do
    t = PT::Field.new('another task')
    expect(t).to_not be_nil
    expect(t.to_markdown).to eq('- another task')
  end

end
