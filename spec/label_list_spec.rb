require 'pt/label_list'

RSpec.describe 'LabelList class' do

  it 'can be constructed, part 1' do
    ll = PT::LabelList.new({})
    expect(ll).to_not be_nil
    expect(ll.labels).to eq([])
    expect(ll.colors).to eq({})
    expect(ll.visited).to eq({})
  end

  it 'can be constructed, part 2' do
    ll = PT::LabelList.new({'Story' => 'a story'})
    expect(ll).to_not be_nil
    expect(ll.labels).to eq([])
    expect(ll.colors).to eq({})
    expect(ll.visited).to eq({})
  end

  it 'can be constructed, part 3' do
    ll = PT::LabelList.new({'Story' => 'a story', 'Labels' => '  foo	'})
    expect(ll).to_not be_nil
    expect(ll.labels).to eq(['foo'])
    expect(ll.colors).to_not be_nil
    expect(ll.colors['foo']).to_not be_nil
    expect(ll.visited).to eq({})
  end

  it 'can be constructed, part 4' do
    ll = PT::LabelList.new({'Story' => 'a story', 'Labels' => '  foo, bar	'})
    expect(ll).to_not be_nil
    expect(ll.labels).to eq(['foo', 'bar'])
    expect(ll.colors).to_not be_nil
    expect(ll.colors['foo']).to_not be_nil
    expect(ll.colors['bar']).to_not be_nil
    expect(ll.visited).to eq({})
  end


end
