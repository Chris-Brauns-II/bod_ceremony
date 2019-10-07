require 'active_support'
require 'date'

require_relative "../../src/date_picker/system_date_picker.rb"

context "" do 
  subject { SystemDatePicker.new }

  it "exists" do 
    expect(subject.class).to eq(SystemDatePicker)
  end

  it "provides the correct date string for yesterday" do 
    expect(subject.yesterday_string).to eq((Date.today - 1).strftime("%Y_%m_%d"))
  end

  it "provides the correct date string for today" do
    expect(subject.today_string).to eq((Date.today).strftime("%Y_%m_%d")) 
  end
end