class ConsoleIO 
  def prompt o
    output o
    input
  end

  def input 
    gets.chomp
  end

  def input_wip
    prompt "what is your wip?:\n"
  end

  def output output
    puts "\n#{output}\n"
    output
  end
end