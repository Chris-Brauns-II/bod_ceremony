class Day
  def initialize wip, completed_tasks
    @wip = wip
    @completed_tasks = completed_tasks
  end

  def wip
    @wip
  end

  def to_json
    {
      "wip" => @wip,
    }.to_json
  end
end
