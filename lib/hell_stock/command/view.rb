module HellStock
  module Command
    class View
      include HellStock::Helper

      attr_accessor :file_list
      attr_accessor :logo_path

      def initialize
        yield(self) if block_given?
        @system = HellStock::Command::System.const_get('LIST_COMMANDS')
      end

      def number(postion)
        if postion.to_i.zero?
          view_menu_message
        else
          File.read(@file_list[postion.to_i - 1])
        end
      end

      def view_menu_message
        message = ['You can search docs by using below numbers: ']
        message << File.read(select_logo_url)
        message << '0 : list menu'

        message << break_line
        message << 'DOCS'
        message << break_line
        @file_list.each_with_index do |file_path, index|
          message << "#{index + 1} | #{File.basename(file_path)}"
        end

        message << break_line
        message << 'COMMANDS'
        message << break_line

        HellStock::Command::System.list_commands.each do |name, intro|
          message << "$#{name} | #{intro.chomp}"
        end
        message << break_line
        message.join("\n") + "\n"
      end

      def break_line
        Array.new(20) { '=' }.join
      end

      private

      def select_logo_url
        random_select(list_all_logo_files)
      end

      def list_all_logo_files
        Dir[logo_path]
      end
    end
  end
end
