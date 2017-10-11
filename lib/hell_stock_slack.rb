require 'eventmachine'
require_relative 'hell_stock/server'
require_relative 'hell_stock/type'
require_relative 'hell_stock/helper'
require_relative 'hell_stock/command/clear'
require_relative 'hell_stock/command/search'
require_relative 'hell_stock/command/system'
require_relative 'hell_stock/command/view'
require 'pry'

class HellStockSlack
  include HellStock::Command

  attr_accessor :logo_path

  ROOT_PATH = Dir.pwd
  p "ROOT_PATH: #{ROOT_PATH}"

  LIST_FILE = Dir[ROOT_PATH + '/stock/**/*.txt'].freeze

  def initialize
    @view = View.new do |c|
      c.file_list = LIST_FILE
      c.logo_path = logo_path
    end

    @search = Search.new do |c|
      c.stock_path = ROOT_PATH
    end
  end

  def slack_response(data:, client:, channel:)
    filter_data = data.strip
    type = HellStock::Type.new(LIST_FILE.size, filter_data)

    if type.search_command?
      results = @search.search(filter_data)
      results.each do |search|
        client.message(channel: channel, text: search)
      end
    elsif type.view_command?
      response = @view.number(filter_data)
      client.message(channel: channel, text: response)
    elsif type.system_command?
      sys = System.new(filter_data)
      response = sys.run!
      client.message(channel: channel, text: response)
    else
      response = "Sorry! I don't know about that *.@ "
      client.message(channel: channel, text: response)
    end
  end
end
