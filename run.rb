#!/usr/bin/env ruby

require_relative 'src/main.rb'
require_relative 'src/datastore/file_datastore.rb'
require_relative 'src/date_picker/system_date_picker.rb'
require_relative 'src/io/console_io.rb'

date_picker = SystemDatePicker.new
datastore = FileDatastore.new date_picker
io = ConsoleIO.new

main = Main.new(datastore, io)

main.run
