#!/usr/bin/env ruby

require_relative 'src/main.rb'
require_relative 'src/datastore/file_datastore.rb'
require_relative 'src/date_picker/system_date_picker.rb'
require_relative 'src/io/console_io.rb'
require_relative 'src/models/day.rb'

require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: bod_ceremony [options]"

  opts.on('-aNOTE', '--append=NOTE', "Append Note to the Current WIP") do |a|
    options[:append] = a
  end

  opts.on('-p', '--print', "print the current day") do |p|
    options[:print] = p
  end
end.parse!


date_picker = SystemDatePicker.new
datastore = FileDatastore.new(date_picker, File.expand_path("~/.wip_store/"))
io = ConsoleIO.new

main = Main.new(io)

if (note = options[:append])
  datastore.commit_note note
elsif (options[:print])
  puts datastore.today.to_s
else
  today_wip = main.yesterday_or_new_prompt(datastore.yesterday_wip, datastore.today_wip)

  datastore.commit_wip(Day.new(today_wip, []))
end

