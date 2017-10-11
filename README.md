# HellStock - Heo

- Pure ruby bot with power of eventmachine

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
HEO_ENV=production ruby script/start_dns_server.rb
# "wellcome to the hell...| server start at 9999"
```

- Now you can connect from your commandline

```
telnet localhost 9999
```

# How to create your own `block`
- create `.hs` file and put it in `system_commands_path` path

First line alway begin with `#` to describe your block and example for user
the second line is command. It can be linux command. 
When we include `xxx` mean that we can pass variant. `xxx` must be include in filename and the second line of commands in `.hs` file (*hell stock file system)

Example. I want create command to view progress on my PC. The command will be like `ps aux | grep -a` I create `L-xxx.hs`

```
# List all file in directory | example for user: $L-ruby
ls -al | grep xxx
```

- When I access to Slack or DNS server. I only type


```
$L-a
```

HellStock will returns

```
total 80
drwxrwxr-x 12 a161114 a161114 4096 Th10 11 14:40 .
drwxrwxr-x  5 a161114 a161114 4096 Th08 23 11:26 ..
drwxrwxr-x  2 a161114 a161114 4096 Th10  6 16:20 bin
drwxrwxr-x  3 a161114 a161114 4096 Th10  6 17:08 block
drwxrwxr-x  3 a161114 a161114 4096 Th07 27 11:09 config
drwxrwxr-x  2 a161114 a161114 4096 Th07 17 08:26 data
-rw-rw-r--  1 a161114 a161114  170 Th10 11 14:47 .env
-rw-rw-r--  1 a161114 a161114  270 Th10  6 17:20 Gemfile
-rw-rw-r--  1 a161114 a161114 3843 Th10  6 17:18 Gemfile.lock
drwxrwxr-x  7 a161114 a161114 4096 Th10 11 15:00 .git
-rw-rw-r--  1 a161114 a161114  231 Th10 11 14:38 .gitignore
drwxrwxr-x  3 a161114 a161114 4096 Th08  8 12:47 lib
drwxrwxr-x  5 a161114 a161114 4096 Th10 11 14:19 public
-rw-rw-r--  1 a161114 a161114 1742 Th10 11 15:08 README.md
-rw-rw-r--  1 a161114 a161114   30 Th10  6 17:19 .rspec
-rw-rw-r--  1 a161114 a161114  309 Th10  6 17:16 .rubocop.yml
drwxrwxr-x  2 a161114 a161114 4096 Th10 11 14:43 script
drwxrwxr-x  2 a161114 a161114 4096 Th10  6 17:19 spec
drwxrwxr-x  4 a161114 a161114 4096 Th10 11 14:34 test
-rw-rw-r--  1 a161114 a161114  148 Th10 11 14:38 .travis.yml

```

You can create `.hs` file and pass variable for your file

Example

```
# Choose random for code review. Ex: $P-linh_http://pull-request-url SENDER=xxx URL=xxx ruby /home/a161114/source/hell-stock/eventmachine-dev/block/random_code_review/random_code_review.rb
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