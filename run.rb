#!/usr/bin/env ruby

require_relative 'src/main.rb'
require_relative 'src/datastore/file_datastore.rb'
require_relative 'src/date_picker/system_date_picker.rb'
require_relative 'src/io/console_io.rb'
require_relative 'src/models/day.rb'

date_picker = SystemDatePicker.new
datastore = FileDatastore.new(date_picker, File.expand_path("~/.wip_store/"))
io = ConsoleIO.new

main = Main.new(io)

today_wip = main.yesterday_or_new_prompt(datastore.yesterday_wip, datastore.today_wip)

datastore.commit_wip(Day.new(today_wip))
