#!/bin/bash

notify-send "Updates:" "`checkupdates | wc -l`"
