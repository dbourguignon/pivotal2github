require 'json'


module PT; end


# Handles columns:
#   - "Labels"


class PT::LabelList
  attr_reader   :labels
  attr_accessor :colors

  @@visited = {}

  def initialize(row)
    parse_row(row)
    @results = {}
  end

  def visited
    @@visited
  end

  def create_labels
    labels.each do |l|
      next if visited[l]
      # STDERR.print "Trying label:  "
      # STDERR.p l
      # # this hack doesn't care if you have an existing label - it just errors and moves on like a zen master
      # # the server however is expected to be equally zen :D
      visited[l] = colors[l]
      json = 
      results[l] = GitHub.post(
        "/repos/#{repository_path}/labels",
        :body => create_json(l)
      )
      # STDERR.p label_result
    end
  end

  private

  def create_json(l)
    JSON.generate({:name => l, :colors => colors[l]})
  end

  def parse_row(row)
    if labels.nil?
      @labels = row['Labels'].to_s.strip
        .split(',')
        .map { |l| l.strip }
      @colors = @labels.inject({}) do |m, l|
        m[l] = random_color
        m
      end
    end
    labels
  end

  def random_color
    3.times.inject('') { |c, n| c << "%02x" % rand(255) }
  end
end
