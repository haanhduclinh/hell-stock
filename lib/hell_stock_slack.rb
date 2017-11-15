require_relative 'hell_stock/init'

class HellStockSlack
  include HellStock::Command

  attr_accessor :logo_path
  attr_accessor :stock_path

  def initialize
    yield(self) if block_given?

    @view = View.new do |c|
      c.file_list = list_files
      c.logo_path = logo_path
    end
    @search = Search.new do |c|
      c.stock_path = stock_path
    end
  end

  def slack_response(data:, client:, channel:)
    filter_data = data.strip
    type = HellStock::Type.new(list_files.size, filter_data)

    if type.search_command?
      results = @search.search(filter_data)
      results.each do |search|
        client.message(channel: channel, text: search)
      end
    elsif type.view_command?
      response = @view.number(filter_data)
      client.message(channel: channel, text: "```#{response}```")
    elsif type.system_command?
      sys = System.new(filter_data)
      response = sys.run!
      client.message(channel: channel, text: response)
    end
  end

  private

  def list_files
    Dir[File.join(stock_path + '**/*.txt')]
  end
end
