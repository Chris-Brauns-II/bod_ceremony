class Main
  def initialize(io)
    @io = io
  end

  def add_completed_task task
  end

  def yesterday_or_new_prompt(yesterday_wip, today_wip)
    if !today_wip.nil?
      answer = @io.prompt "You have entered:\n\s\s#{today_wip}\nWould you like to change it? (y/n) "

      case answer
      when "y" then
      when "n" then return today_wip
      else
        raise "Invalid Answer: #{answer}"
      end
    end

    if yesterday_wip.nil?
      @io.input_wip
    else
      answer = @io.prompt "Yesterday you worked on:\n\s\s#{yesterday_wip}\nIs that what you're doing today? (y/n) "

      case answer
      when "y" then yesterday_wip
      when "n" then @io.input_wip
      else
        raise "Invalid Answer: #{answer}"
      end
    end
  end

  def _new_wip
    @io.prompt_input "What is your WIP?:"
  end
end
