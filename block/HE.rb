require './lib/hell_stock/command/block_base'
require 'time_difference'
require 'date'

module HellStock
  module Command
    class HE < BlockBase
      def name
        "System manager"
      end

      def example_to_use
        "$HE -h"
      end

      def run!
        begin
          opt_parser = OptionParser.new do |opts|
            banner(opts)

            opts.on("-t", "--[no-]telnet", "get connect telnet dns sever") do |_a|
              return view_dns
            end

            opts.on("-g", "--[no-]guide", "guide for contributor") do |_a|
              return view_guide
            end

            opts.on("-h", "--help", "Prints this help.") do
              return opts.to_s
            end

            opts.on("-do", "--[no-]todolist", "Prints this todo list") do |_b|
              return view_todo
            end

            opts.on("-v", "--version", "Prints version") do
              return version
            end
          end

          parse!(opt_parser)
        rescue => e
          return e.message
        end
      end

      private

      def view_dns
        dns = "ip route get 1 | awk '{print $NF;exit}'"
        response = Open3.capture3(dns)
        "telnet #{response.first.chomp} 9999"
      end

      def view_guide
        "https://github.com/haanhduclinh/hell-stock#how-to-contributor"
      end

      def version
        "2.0.0"
      end

      def view_todo
        todo = []
        todo << "1. Fix rubocop https://github.com/haanhduclinh/hell-stock"
        todo << "2. Write more unit test and rrrspec test"
        todo << "3. Update README.md"
        todo << "4. Encypt and Descrypt all data on public/stock use ENV['MASTER_KEY']\n"
        todo.join("\n")
      end
    end
  end
end