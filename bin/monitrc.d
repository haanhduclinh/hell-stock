check process hellstock matching "hellstock"
  start program = "/usr/bin/ruby /home/a161114/source/hell-stock/eventmachine/chat.rb"
  stop program = "/usr/bin/killall hellstock"
  if cpu usage > 95% for 2 cycles then restart