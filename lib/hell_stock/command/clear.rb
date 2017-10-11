module HellStock
  module Command
    module Clear
      module_function

      def clear(connections:)
        connections.each do |connection|
          connection.send_data "\033c"
        end
      end
    end
  end
end
