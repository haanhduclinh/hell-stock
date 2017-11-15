require 'dotenv/load'

require 'pry'
require 'config'
require 'optparse'
require 'eventmachine'
require 'open3'

Config.load_and_set_settings(
  Config.setting_files('./config', ENV['HEO_ENV'])
)

require_relative 'server'
require_relative 'type'
require_relative 'helper'
require_relative 'command/clear'
require_relative 'command/search'
require_relative 'command/system'
require_relative 'command/view'

Dir["./block/**/*.rb"].each {|file| require file }