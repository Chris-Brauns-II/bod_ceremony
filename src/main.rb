class Main
  def initialize(datastore, io)
    @datastore = datastore
    @io = io
  end

  def run 
    @io.output(
      "You are working on:\n\s\s" +
      @datastore.commit_wip(
        _resolve_wip(
          @datastore.yesterday_wip
        )
      )
    )
  end

  def _resolve_wip yesterday_wip 
    today_wip =
      if yesterday_wip.nil?
        _new_wip
      else
        _yesterday_to_today_wip yesterday_wip
      end
  end

  def _new_wip
    @io.output "What is your WIP?:" 
    @io.input
  end

  def _yesterday_to_today_wip yesterday_wip
    @io.output "Yesterday you worked on:\n\s\s#{yesterday_wip}\nIs that what you're doing today? (y/n) "
    answer = @io.input

    return yesterday_wip if answer == "y"
    return _new_wip if answer == "n"
  end
end