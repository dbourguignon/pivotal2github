module PT; end
class PT::Task
  attr_reader   :text, :blocker, :status

  def initialize(text, blocker = false)
    @text    = text
    @blocker = blocker
    @status  = 'not completed'
  end

  def completed?
    status == 'completed'
  end

  def to_markdown
    "- [#{completed_markdown}] #{text_markdown}"
  end

  def status=(s)
    @status = s.to_s.strip.downcase
  end

  private

  def text_markdown
    blocker ? "__Blocker__: #{text}" : text
  end


  def completed_markdown
    completed? ? 'x' : ' '
  end
end
