class Day
  def initialize(wip, notes)
    @wip = wip || nil
    @notes = notes || []
  end

  def self.add_note(day, note)
    Day.new(
      day.wip,
      day.notes << note
    )
  end

  def self.from_json json
    Day.new(
      json["wip"],
      json["notes"]
    )
  end

  def wip
    @wip
  end

  def notes
    @notes
  end

  def to_json
    {
      "wip" => wip,
      "notes" => @notes
    }.to_json
  end

  def to_s
    JSON.pretty_generate JSON.parse to_json
  end

  def == other
    other.wip == wip && other.notes == notes
  end
end
