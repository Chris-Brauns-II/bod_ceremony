class Day
  def initialize wip
    @wip = wip
  end

  def wip
    @wip
  end

  def to_json
    {
      "wip" => wip
    }.to_json
  end
end