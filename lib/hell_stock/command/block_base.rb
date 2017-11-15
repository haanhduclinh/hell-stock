module HellStock
  module Command
    class BlockBase
      attr_accessor :command

      def initialize(command = nil)
        self.command = command
      end

      def describe
        "#{name} | Ex: #{example_to_use}"
      end

      def name
        "This is base class to create the block command"
      end

      def example_to_use
        "$H -h hello"
      end

      def run!
        opt_parser = OptionParser.new do |opts|
          banner(opts)

          opts.on("-nNAME", "--name=NAME", "Name to say hello to") do |n|
            return n
          end

          opts.on("-h", "--help", "Prints help") do
            return opts.to_s
          end

          opts.on("-v", "--version", "Prints version") do
            return version
          end
        end

        parse!(opt_parser)
      end

      private

      def banner(opts)
        opts.banner = describe
      end

      def version
        "0.0.1"
      end

      def parse!(opt_parser)
        options = command.split(" ")
        opt_parser.parse!(options)
      end
    end
  end
end