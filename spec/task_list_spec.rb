require 'pt/task'
require 'pt/task_list'

RSpec.describe 'PT::TaskList class' do

  before {
    @tl1 = PT::TaskList.new(
      [['Story', 'a story'],
       ['Blocker', 'A blocker'],
       ['Blocker Status', 'not completed'],
       ['Task', 'A task'],
       ['Task Status', "\t coMPLETed\t  "],
       ['Other Field', 'who cares?']]
    )
    @tl2 = PT::TaskList.new(
      [['Story', 'a story'],
       ['Blocker', 'A blocker'],
       ['Blocker Status', 'not completed'],
       ['Task', 'A task'],
       ['Task Status', 'not completed'],
       ['Task', 'Task 2'],
       ['Task Status', "\t coMPLETed\t  "],
       ['Blocker', 'Blocker 2'],
       ['Blocker Status', "\t coMPLETed\t  "],
       ['Other Field', 'who cares?']]
    )
    @md1 =
      "- [ ] __Blocker__: A blocker\n" +
      "- [x] A task"
    @md2 =
      "- [ ] __Blocker__: A blocker\n" +
      "- [ ] A task\n" +
      "- [x] Task 2\n" +
      "- [x] __Blocker__: Blocker 2"
  }

  def check_task(task,
                 text,
                 blocker: false,
                 status: 'not completed')
    # Allow for nil tasks:
    return expect(task).to(be_nil) if text.nil?

    expect(task).to_not be_nil
    expect(task).to be_a(PT::Task)
    expect(task.text).to eq(text)
    expect(task.blocker).to eq(blocker)
    expect(task.status).to eq(status)
  end

  it 'can be constructed, part 1' do
    tl = PT::TaskList.new([])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to eq([])
  end


  it 'can be constructed, part 2' do
    tl = PT::TaskList.new([['Story', 'a story']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to eq([])
  end


  it 'can handle tasks, part 1' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Task', 'A task'],
                           ['Task Status', 'not completed'],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(1)
    check_task(tl.tasks[0], 'A task')
  end

  it 'can handle tasks, part 2' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Task', 'A task'],
                           ['Task Status', 'not completed'],
                           ['Task', 'Task 2'],
                           ['Task Status', "\t coMPLETed\t  "],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(2)
    check_task(tl.tasks[0], 'A task')
    check_task(tl.tasks[1], 'Task 2', status: 'completed')
  end


  it 'can handle blockers, part 1' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Blocker', 'A blocker'],
                           ['Blocker Status', 'not completed'],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(1)
    check_task(tl.tasks[0], 'A blocker', blocker: true)
  end

  it 'can handle blockers, part 2' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Blocker', 'A blocker'],
                           ['Blocker Status', 'not completed'],
                           ['Blocker', 'Blocker 2'],
                           ['Blocker Status', "\t coMPLETed\t  "],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(2)
    check_task(tl.tasks[0], 'A blocker', blocker: true)
    check_task(tl.tasks[1], 'Blocker 2', blocker: true, status: 'completed')
  end


  it 'can handle blockers and tasks, part 1' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Blocker', 'A blocker'],
                           ['Blocker Status', 'not completed'],
                           ['Task', 'A task'],
                           ['Task Status', "\t coMPLETed\t  "],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(2)
    check_task(tl.tasks[0], 'A blocker', blocker: true)
    check_task(tl.tasks[1], 'A task', status: 'completed')
  end

  it 'can handle blockers and tasks, part 2' do
    tl = PT::TaskList.new([['Story', 'a story'],
                           ['Blocker', 'A blocker'],
                           ['Blocker Status', 'not completed'],
                           ['Task', 'A task'],
                           ['Task Status', 'not completed'],
                           ['Task', 'Task 2'],
                           ['Task Status', "\t coMPLETed\t  "],
                           ['Blocker', 'Blocker 2'],
                           ['Blocker Status', "\t coMPLETed\t  "],
                           ['Other Field', 'who cares?']])
    expect(tl).to be_a(PT::TaskList)
    expect(tl.tasks).to be_a(Array)
    expect(tl.tasks.length).to eq(4)
    check_task(tl.tasks[0], 'A blocker', blocker: true)
    check_task(tl.tasks[1], 'A task')
    check_task(tl.tasks[2], 'Task 2', status: 'completed')
    check_task(tl.tasks[3], 'Blocker 2', blocker: true, status: 'completed')
  end

  it 'creates markdown, part 1' do
    expect(@tl1).to be_a(PT::TaskList)
    expect(@tl1.to_markdown).to eq(@md1)
  end

  it 'creates markdown, part 2' do
    expect(@tl2).to be_a(PT::TaskList)
    expect(@tl2.to_markdown).to eq(@md2)
  end

  it 'creates a body, part 1' do
    expect(@tl1).to be_a(PT::TaskList)
    expect(@tl1.body).to eq({:body => @md1})
  end

  it 'creates a body, part 2' do
    expect(@tl2).to be_a(PT::TaskList)
    expect(@tl2.body).to eq({:body => @md2})
  end


  # TODO

  it 'can post a comment, part 1' do; end

end
