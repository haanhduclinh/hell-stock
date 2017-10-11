module HellStock
  class Type
    SEARCH_COMMAND_TYPE = '@'.freeze
    SYSTEM_COMMAND_TYPE = '$'.freeze
    MAX_STORE = 50

    def initialize(number_of_file, command)
      @number_of_file = number_of_file
      @command = command
      yield if block_given?
    end

    def view_command?
      (0..@number_of_file + 1).map(&:to_s).include? @command
    end

    def search_command?
      @command.start_with? SEARCH_COMMAND_TYPE
    end

    def system_command?
      @command.start_with? SYSTEM_COMMAND_TYPE
    end

    def clear_command?(current_stock: [])
      current_stock.size >= MAX_STORE
    end
  end
end
