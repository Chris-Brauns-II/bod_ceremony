class FileDatastore 
  def initialize(date_picker, commit_directory)
    @date_picker = date_picker
    @commit_directory = commit_directory
  end

  def yesterday_wip 
    yesterday_string = @date_picker.yesterday_string

    file_path = _file_path yesterday_string

    return nil unless File.exists? file_path
    file = File.open file_path

    file.read
  end 

  def commit_wip wip
    file_path = _file_path @date_picker.today_string
    file = File.open(file_path, "w")
    file.puts(wip) 
    file.close
    wip
  end

  def _file_path file_name
    "#{@commit_directory}/#{file_name}"
  end
end