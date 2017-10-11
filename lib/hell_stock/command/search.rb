module HellStock
  module Command
    class Search
      attr_accessor :stock_path

      def initialize
        yield(self) if block_given?
      end

      def search(cmd)
        keyword = cmd[1..-1]
        result = []
        docs = Dir[@stock_path + '/**/*txt']
        docs.each do |file_path|
          File.readlines(file_path).each do |line|
            result << line if line.downcase.include?(keyword.downcase)
          end
        end

        if result.uniq.size.zero?
          ["Hum...It seem doesn't exist this command x.x \n"]
        else
          result.uniq.map do |line|
            line
          end
        end
      end
    end
  end
end
