#!/bin/bash


pactl set-port-latency-offset $(pactl list cards short | egrep -o bluez.*[[:space:]]) speaker-output 250000
