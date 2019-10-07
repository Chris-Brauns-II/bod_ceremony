class FileDatastore 
  def initialize date_picker 
    @date_picker = date_picker
  end

  def yesterday_wip 
    yesterday_string = @date_picker.yesterday_string

    return nil unless File.exists? yesterday_string
    file = File.open yesterday_string

    file.read
  end 

  def commit_wip wip
    today_string = @date_picker.today_string
    file = File.open(today_string, "w")
    file.puts(wip) 
    file.close
    wip
  end
end