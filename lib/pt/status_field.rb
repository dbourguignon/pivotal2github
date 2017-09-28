require_relative 'field'

module PT; end
class PT::StatusField < PT::Field
  attr_reader :status

  def initialize(text, status: 'not completed')
    super(text)
    @text    = text
    @status  = status
  end

  def completed?
    status == 'completed'
  end

  def status=(s)
    @status = s.to_s.strip.downcase
  end

  private

  def text_markdown
    "[#{completed_markdown}] #{text}"
  end


  def completed_markdown
    completed? ? 'x' : ' '
  end
end
