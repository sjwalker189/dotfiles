 #!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
killall -q polybar

polybar --config=./config.ini main 2>&1 | tee -a /tmp/polybar_main.log & disown

