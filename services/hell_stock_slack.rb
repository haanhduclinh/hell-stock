require_relative '../lib/hell_stock_slack'

require 'slack-ruby-client'
require 'terminal-table'

TOKEN = Settings.slack_api

Slack.configure do |config|
  config.token = TOKEN
end

Config.load_and_set_settings(
  Config.setting_files('./config', ENV['HEO_ENV'])
)

Slack::Web::Client.config do |config|
  config.user_agent = 'Slack Ruby Client/1.0'
end

client = Slack::RealTime::Client.new

heo = HellStockSlack.new do |c|
  c.logo_path = Settings.logo_path
  c.stock_path = Settings.stock_path
end

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to \
  the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  heo.slack_response(data: data.text, client: client, channel: data.channel)
end

client.on :close do |_data|
  puts 'Client is about to disconnect'
end

client.on :closed do |_data|
  puts 'Client has disconnected successfully!'
end

client.start!
