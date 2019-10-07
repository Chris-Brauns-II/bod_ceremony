class Main
  def initialize(io)
    @io = io
  end

  def yesterday_or_new_prompt yesterday_wip 
    if yesterday_wip.nil?
      @io.input_wip
    else
      answer = @io.prompt_input "Yesterday you worked on:\n\s\s#{yesterday_wip}\nIs that what you're doing today? (y/n) "

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