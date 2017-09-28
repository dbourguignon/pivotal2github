module PT; end
class PT::Field
  attr_reader :text

  def initialize(text)
    @text    = text
  end

  def to_markdown
    "- #{text_markdown}"
  end

  private

  def text_markdown
    text
  end

end

