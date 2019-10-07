class ConsoleIO 
  def prompt_input o
    output o
    input
  end

  def input 
    gets
  end

  def output output
    puts "\n#{output}\n"
    output
  end
end