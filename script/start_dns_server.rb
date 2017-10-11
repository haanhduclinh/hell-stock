require 'dotenv/load'
require 'pry'
require 'config'

Config.load_and_set_settings(
  Config.setting_files('./config', ENV['HEO_ENV'])
)

require_relative '../lib/hell_stock'

HellStock::Server.run(port: 9999, controller_class: HellStock) do
  p 'wellcome to the hell...| server start at 9999'
end
