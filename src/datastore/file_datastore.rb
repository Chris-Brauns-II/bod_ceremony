require 'json'

class FileDatastore
  def initialize(date_picker, commit_directory)
    @date_picker = date_picker
    @commit_directory = commit_directory
  end

  def yesterday_wip
    _read_wip_from_file @date_picker.yesterday_string
  end

  def today_wip
    _read_wip_from_file @date_picker.today_string
  end

  def commit_wip wip
    file_path = _file_path @date_picker.today_string
    file = File.open(file_path, "w")
    file.write(wip.to_json)
    file.close
    wip
  end

  def _read_wip_from_file file_name
    day = _read_file file_name

    return if day.nil?
    day["wip"]
  end

  def _read_file file_name
    file_path = _file_path file_name

    return nil unless File.exists? file_path
    file = File.open file_path

    JSON.parse file.read
  end

  def _file_path file_name
    "#{@commit_directory}/#{file_name}.json"
  end
end
