require 'eventmachine'
require_relative 'hell_stock/server'
require_relative 'hell_stock/type'
require_relative 'hell_stock/helper'
require_relative 'hell_stock/command/clear'
require_relative 'hell_stock/command/search'
require_relative 'hell_stock/command/system'
require_relative 'hell_stock/command/view'
require 'pry'

module HellStock
  include HellStock::Command

  %i[connections session messages].each do |attr|
    attr_accessor attr
  end

  LIST_FILE = Dir[Settings.stock_path + '/**/*.txt'].freeze

  def post_init
    @@messages ||= []
    @@connectionss ||= []
    @@session ||= []

    @view = View.new do |c|
      c.file_list = LIST_FILE
      c.logo_path = Settings.logo_path
    end

    @@connectionss << self
    send_data "Welcome to hell stock \n"
    send_data @view.view_menu_message
    send_data "Please enter your name: \n"
    @search = Search.new do |c|
      c.stock_path = Settings.stock_path
    end
  end

  def receive_data(data)
    filter_data = data.strip
    type = Type.new(LIST_FILE.size, filter_data)

    if type.clear_command?(current_stock: @@messages)
      @@messages = []
      clear(connections: @@connectionss)
    end

    if type.search_command?
      results = @search.search(filter_data)
      results.each do |search|
        send_data(search)
      end
    elsif type.view_command?
      send_data(@view.number(filter_data))
    elsif type.system_command?
      sys = System.new(filter_data)
      send_data(sys.run!)
    else
      chat(filter_data)
    end
  end

  def unbind
    @@connectionss.delete(self)
    @@connectionss.each do |connection|
      connection.send_data("#{@name} left")
    end
  end

  def chat(data)
    @new_joined = @name.nil? ? true : false
    @name ||= data
    @@messages << { name: @name, message: data }

    if @new_joined
      @@messages.each do |msg|
        if msg[:message] == 'exit'
          send_data "#{msg[:name]} left\n"
        else
          send_data "#{msg[:name]}: #{msg[:message]}\n"
        end
      end
    end

    @@connectionss.each do |connection|
      close_connection if data == 'exit'

      if connection != self
        if @new_joined
          connection.send_data "#{@name} joined\n"
        else
          connection.send_data "#{@name}: #{data}\n"
        end
      end
    end
  end
end
