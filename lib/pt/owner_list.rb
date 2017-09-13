module PT; end


# Handles columns:
#   - "Owned By"


class PT::OwnerList
  attr_reader :owners

  def initialize(row)
    @owners = nil
    parse_row(row)
  end

  def to_markdown
    case owners.length
    when 0
      'Original owners:  None'
    when 1
      "Original owner:  #{owners[0]}"
    else
      "Original owners:\n  - " + owners.join("\n  - ")
    end
  end

  private

  def parse_row(row)
    if @owners.nil?
      @owners = []
      row.each do |f|
        if 'owned by' == f[0].downcase && "" != f[1].to_s.strip
          @owners.push(f[1].to_s.strip)
        end
      end
    end
    owners
  end
end
