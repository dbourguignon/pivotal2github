module PT2GHHelper
  class ExpectedMarkdown

    @@spec_dir     = File.dirname(File.dirname(File.dirname(__FILE__)))
    @@markdown_dir = File.join(@@spec_dir, 'expected_markdown')

    attr_reader :index, :path, :markdown

    def initialize(index)
      @index    = index
      @path     = File.join(@@markdown_dir, "#{index}.md")
      @markdown = load_markdown
    end

    private

    def load_markdown()
      File.read(path)
    end
  end
end
