#!/bin/sh
set -e

# Shows the bar and makes space
showpoly() {
  local m=$(bspc query -M -m --names)
  local p=$(grep pid $HOME/.cache/polybar/config_$m.ini | \
    sed 's/.*= \?[a-zA-Z0-9]* \([a-zA-Z0-9]*\).*/\1/')
  polybar-msg -p $p cmd show
  bspc config -m $m top_padding 27
}

# Hides the bar and reclaims space
hidepoly() {
  local m=$(bspc query -M -m --names)
  local p=$(grep pid $HOME/.cache/polybar/config_$m.ini | \
    sed 's/.*= \?[a-zA-Z0-9]* \([a-zA-Z0-9]*\).*/\1/')
  polybar-msg -p $p cmd hide
  bspc config -m $m top_padding 0
}

# Decides whether to show or hide based on space
togglepoly() {
  local m=$(bspc query -M -m --names)
  if [ $(bspc config -m $m top_padding) == 0 ] 
  then
    showpoly
  else
    hidepoly
  fi
}

# Show, hide or toggle
case $1 in
  show)   showpoly ;;
  on)     showpoly ;;
  hide)   hidepoly ;;
  off)    hidepoly ;;
  toggle) togglepoly ;;
  *)      togglepoly ;;
esac
