require 'pt/owner_list'

RSpec.describe 'PT::OwnerList class' do

  it 'can be constructed, part 1' do
    ol = PT::OwnerList.new([])
    expect(ol).to_not be_nil
    expect(ol.owners).to eq([])
  end

  it 'can be constructed, part 2' do
    ol = PT::OwnerList.new([['Story', 'a story']])
    expect(ol).to_not be_nil
    expect(ol.owners).to eq([])
  end


  it 'can be constructed, part 3' do
    ol = PT::OwnerList.new([['Story', 'a story'], ['Owned By', "\tFoo Bar "]])
    expect(ol).to_not be_nil
    expect(ol.owners).to eq(['Foo Bar'])
  end

  it 'can be constructed, part 4' do
    ol = PT::OwnerList.new([['Story', 'a story'],
                            ['Owned By', "\tFoo Bar "],
                            ['Owned By', "Bar Baz "],
                            ['Status', 'Completed']])
    expect(ol).to_not be_nil
    expect(ol.owners).to eq(['Foo Bar', 'Bar Baz'])
  end

  it 'can create markdown, part 1' do
    ol = PT::OwnerList.new([])
    expect(ol).to_not be_nil
    expect(ol.to_markdown).to eq('Original owners:  None')
  end


  it 'can create markdown, part 2' do
    ol = PT::OwnerList.new([['Story', 'a story'], ['Owned By', "\tFoo Bar "]])
    expect(ol).to_not be_nil
    expect(ol.to_markdown).to eq('Original owner:  Foo Bar')
  end

  it 'can create markdown, part 2' do
    ol = PT::OwnerList.new([['Story', 'a story'],
                            ['Owned By', "\tFoo Bar "],
                            ['Owned By', "Bar Baz "],
                            ['Status', 'Completed']])
    expect(ol).to_not be_nil
    expect(ol.to_markdown).to eq(
      "Original owners:\n  - Foo Bar\n  - Bar Baz")
  end

end
