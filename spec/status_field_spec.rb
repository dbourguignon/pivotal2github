require 'pt/status_field'

RSpec.describe 'PT::StatusField class' do

  it 'can be constructed, part 1' do
    t = PT::StatusField.new('a task')
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
  end

  it 'can be constructed, part 2' do
    t = PT::StatusField.new('another task')
    expect(t).to_not be_nil
    expect(t.text).to eq('another task')
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
  end

  it 'can have its status changed' do
    t = PT::StatusField.new('a task')
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
    t.status = " \t COmpLEtED "
    expect(t.status).to eq('completed')
    expect(t.completed?).to be_truthy
  end

  it 'can handle nil status' do
    t = PT::StatusField.new('a task')
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
    t.status = nil
    expect(t.status).to eq('')
    expect(t.completed?).to be_falsey
  end

  it 'generates appropriate markdown, part 1' do
    t = PT::StatusField.new('A task')
    expect(t).to_not be_nil
    expect(t.completed?).to be_falsey
    expect(t.to_markdown).to eq('- [ ] A task')
  end

  it 'generates appropriate markdown, part 2' do
    t = PT::StatusField.new('Another task')
    expect(t).to_not be_nil
    t.status = 'completed'
    expect(t.completed?).to be_truthy
    expect(t.to_markdown).to eq('- [x] Another task')
  end

end
