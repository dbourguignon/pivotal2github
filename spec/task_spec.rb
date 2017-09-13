require 'pt/task'

RSpec.describe 'PT::Task class' do

  it 'can be constructed, part 1' do
    t = PT::Task.new('a task')
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.blocker).to be_falsey
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
  end

  it 'can be constructed, part 2' do
    t = PT::Task.new('another task')
    expect(t).to_not be_nil
    expect(t.text).to eq('another task')
    expect(t.blocker).to be_falsey
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
  end

  it 'can be constructed, part 3' do
    t = PT::Task.new('a task', true)
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.blocker).to be_truthy
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
  end

  it 'can have its status changed' do
    t = PT::Task.new('a task', true)
    expect(t).to_not be_nil
    expect(t.text).to eq('a task')
    expect(t.blocker).to be_truthy
    expect(t.status).to eq('not completed')
    expect(t.completed?).to be_falsey
    t.status = " \t COmpLEtED "
    expect(t.status).to eq('completed')
    expect(t.completed?).to be_truthy
  end

  it 'generates appropriate markdown, part 1' do
    t = PT::Task.new('A task')
    expect(t).to_not be_nil
    expect(t.completed?).to be_falsey
    expect(t.to_markdown).to eq('  - [ ] A task')
  end

  it 'generates appropriate markdown, part 2' do
    t = PT::Task.new('Another task')
    expect(t).to_not be_nil
    t.status = 'completed'
    expect(t.completed?).to be_truthy
    expect(t.to_markdown).to eq('  - [x] Another task')
  end

  it 'generates appropriate markdown, part 3' do
    t = PT::Task.new('Another task', true)
    expect(t).to_not be_nil
    expect(t.completed?).to be_falsey
    expect(t.to_markdown).to eq('  - [ ] __Blocker__: Another task')
  end

  it 'generates appropriate markdown, part 4' do
    t = PT::Task.new('A task', true)
    expect(t).to_not be_nil
    t.status = 'completed'
    expect(t.completed?).to be_truthy
    expect(t.to_markdown).to eq('  - [x] __Blocker__: A task')
  end

end
