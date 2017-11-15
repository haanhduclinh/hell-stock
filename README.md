# HellStock - Heo

- Pure ruby bot with power of eventmachine

[![Code Climate](https://codeclimate.com/github/haanhduclinh/hell-stock.png)](https://codeclimate.com/github/haanhduclinh/hell-stock) [![CI](https://travis-ci.org/haanhduclinh/hell-stock.svg?branch=master)](https://travis-ci.org/haanhduclinh/hell-stock) [![Coverage Status](https://coveralls.io/repos/github/haanhduclinh/hell-stock/badge.svg?branch=master)](https://coveralls.io/github/haanhduclinh/hell-stock?branch=master)


# What can we do with HellStock

 - Store document on local machine, easily to view as commanline
 - Create your own command with `block`. All you need is create your ruby file and put to block folder. `HellStock` will know your `block` and run it
 - Realtime chat with dns server
 - Work with Slack

# Installation

- Clone to this repo
- Settings your `Hell Stock`

-- Document path
-- System command path
-- `SLACK_API_KEY` key if you want connect with slack

Example `.env`

```
SLACK_API_KEY=xxx-xxxx-xxxx
LOGO_PATH=public/images/logo/**/*.txt
STOCK_PATH=public/stock
SYSTEM_COMMANDS_PATH=public/system_commands/**/*.hs

```

- start dns server on script folder

```
$ sh bin/dns.sh
# "wellcome to the hell...| server start at 9999"
```

- Now you can connect from your commandline

```
telnet localhost 9999
```

# How to create your own `block`
- create `.rb` file and put it in `block` path
- Example

```
# block/HE.rb
# you command will be: $HE
# to use BlockBase class
require './lib/hell_stock/command/block_base'

# require only for your block
require 'time_difference'
require 'date'

module HellStock
  module Command
    # class name must same with file name HE
    class HE < BlockBase

      # name of your block. I will be display when type command
      def name
        "System manager"
      end

      # Emxmple. I will be display when type command
      def example_to_use
        "$HE -h"
      end

      # all your code will be run! in this methods
      def run!
        begin
          opt_parser = OptionParser.new do |opts|
            banner(opts)

            opts.on("-t", "--[no-]telnet", "get connect telnet dns sever") do |_a|
              return view_dns
            end

            # you need to add this to hear. This is add true or false
            opts.on("-g", "--[no-]guide", "guide for contributor") do |_a|
              return view_guide
            end

            # if you need pass data as params. You can do like that
            opts.on("-bBRAND", "--branch=BRAND", "your branch name") do |n|
              # n = your branch

              # return string. I will be display
              return display_link(n)
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

      # display your block version. Default: 0.0.1

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
```


# How to contributor

- Folk project
- Create pull request (*Make sure include test. Both unit test and rspec accepted)

# Todo

- Write more test. I want cover 100%
- Improve performace
- Refactor code

# License

- MIT

# Author

Thanks to
- haanhduclinh.com
- duytd