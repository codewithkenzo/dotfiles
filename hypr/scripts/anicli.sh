#!/usr/bin/env bash

function fish_greeting {
  kitty --override font_size=14 --class ani-cli pokemon-colorscripts -r 1,2,3 --no-title
  ani-cli &
}
