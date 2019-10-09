require 'date'

class SystemDatePicker
  def yesterday_string
    _format Date.today - 1
  end

  def today_string
    _format Date.today
  end

  def _format date
    date.strftime("%Y_%m_%d")
  end
end
