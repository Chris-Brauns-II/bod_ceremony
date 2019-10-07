class ConsoleIO 
  def prompt_input o
    output o
    input
  end

  def input 
    gets.chomp
  end

  def input_wip
    prompt_input "what is your wip?:\n"
  end

  def output output
    puts "\n#{output}\n"
    output
  end
end