#!/bin/sh

pactl list sources | grep -qi 'Mute: yes' && pactl set-source-mute 1 false || pactl set-source-mute 1 true
