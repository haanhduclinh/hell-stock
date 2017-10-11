require 'coveralls'
Coveralls.wear!

require 'test/unit'
require 'config'
Config.load_and_set_settings(
  Config.setting_files('./config', ENV['HEO_ENV'])
)