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
          signal = get_symbol(command_path)
          command_type << command_path if main_command.start_with?(signal)
        end

        if command_type.size.zero?
          "Currently, we don't have this command: #{main_command}\n"
        else
          load_command(command_type.first, main_command)
        end
      end

      def self.list_commands
        LIST_COMMANDS.map do |command_path|
          command_syntax = File.basename(command_path, '.hs')
          intro, _command = File.readlines(command_path)
          [command_syntax, intro]
        end
      end

      private

      def load_command(file_path, main_command)
        _intro, command = File.readlines(file_path)
        command_syntax = command_struct(file_path)

        if exist_variant?(command_syntax)
          full_command = variant_command(file_path, main_command, command)
          `#{full_command}`
        else
          `#{command}`
        end
      rescue => e
        "Error ~.~ | #{e.message} \n"
      end

      # Ex: $ABC-FIRST-VARIANT_SECOND-VARIANT
      def variant_command(file_path, main_command, command)
        c_name = get_symbol(file_path)
        end_point = main_command.index("-") + 1
        variant = main_command[end_point..-1]
        number_of_variant = variant.split("_")
        number_of_variant.each do |variant|
          command.sub!('xxx', variant)
        end
        command
      end

      def get_symbol(path)
        file_name = File.basename(path, '.hs')
        file_name.split('-').first
      end

      def command_struct(file_path)
        File.basename(file_path, '.hs')
      end

      def exist_variant?(file_name)
        file_name.include?("-") && file_name.include?("xxx")
      end
    end
  end
end
