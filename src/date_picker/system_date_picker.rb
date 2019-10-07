require 'date'

class SystemDatePicker 
  def yesterday_string 
    (Date.today - 1).strftime("%Y_%m_%d")
  end

  def today_string 
    (Date.today).strftime("%Y_%m_%d")
  end
end