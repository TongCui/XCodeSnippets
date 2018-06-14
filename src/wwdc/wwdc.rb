#!/usr/bin/env ruby

require 'restclient'
require 'oga'
require 'json'
require 'date'
require 'optparse'
require_relative 'models'

options = {}
optparse = OptionParser.new do|opts|
  
  opts.banner = "Usage: wwdc.rb [options] file1 file2 ..."
  
  opts.on( '-w', '--web web', 'wwdc page link' ) do |web|
    options[:web] = web
  end
  
  options[:year] = "2018"
  opts.on( '-y', '--year YEAR', 'wwdc year' ) do |year|
    options[:year] = year
  end
  
  opts.on( '-s', '--session NUMBER', 'session number' ) do|session|
    options[:session] = session
  end

  options[:sd] = false
  opts.on( '-s', '--sd', 'SD or HD quality' ) do
    options[:sd] = true
  end

  options[:list] = false
  opts.on( '-l', '--list', 'list sessions' ) do
    options[:list] = true
  end
  
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end
optparse.parse!


def get_wwdc_model(year)
  case year
    when "2018"
      WWDC2018.new
      
  end
end

puts options

wwdc2018 = WWDC2018.new
wwdc2017 = WWDC2017.new

puts wwdc2018.url
puts wwdc2017.url

puts wwdc2018.get_sessions

# puts "Being verbose" if options[:verbose]
# puts "Being quick" if options[:quick]
# puts "Logging to file #{options[:logfile]}" if options[:logfile]
