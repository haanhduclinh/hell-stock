module HellStock
  module Command
    class System
      LIST_COMMANDS = Dir[::Settings.system_commands_path]

      def initialize(command)
        @command = command
        yield(self) if block_given?
      end

      def run!
        main_command = @command[1..-1]
        command_type = []

        LIST_COMMANDS.each do |command_path|
          command = File.basename(command_path, '.rb')
          command_type << command if main_command.start_with?(command)
        end

        if command_type.size.zero?
          "Currently, we don't have this command: #{main_command}\n"
        else
          class_name = command_type.first
          load_class = Object.const_get("HellStock::Command::#{class_name}")
          load_class.new(main_command).run!
        end
      end

      def self.list_commands
        LIST_COMMANDS.map do |command_path|
          command_syntax = File.basename(command_path, '.rb')
          intro = Object.const_get("HellStock::Command::#{command_syntax}").new.send("describe")
          [command_syntax, intro]
        end
      end
    end
  end
end
