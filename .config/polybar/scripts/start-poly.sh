#!/bin/sh

# Creates the file if it doesn't exist
createIfNotExist() {
  if [ ! -f $1 ] || \
      ! grep -q 'pid'         $1 || \
      ! grep -q 'theme'       $1 || \
      ! grep -q 'bg'          $1 || \
      ! grep -q 'fg'          $1 || \
      ! grep -q 'ac'          $1 || \
      ! grep -q 'trans'       $1 || \
      ! grep -q 'white'       $1 || \
      ! grep -q 'black'       $1 || \
      ! grep -q 'red'         $1 || \
      ! grep -q 'pink'        $1 || \
      ! grep -q 'purple'      $1 || \
      ! grep -q 'indigo'      $1 || \
      ! grep -q 'blue'        $1 || \
      ! grep -q 'cyan'        $1 || \
      ! grep -q 'teal'        $1 || \
      ! grep -q 'green'       $1 || \
      ! grep -q 'lime'        $1 || \
      ! grep -q 'yellow'      $1 || \
      ! grep -q 'amber'       $1 || \
      ! grep -q 'orange'      $1 || \
      ! grep -q 'brown'       $1 || \
      ! grep -q 'grey'        $1 || \
      ! grep -q 'blue-gray'   $1; \
    then
      echo "Creating polybar config file: $1.."
      cp -f $HOME/.config/polybar/config.ini $1
    else
      echo "Found polybar config file: $1.."
  fi
}

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# If multiple bars may exist
if type "xrandr"; then

  # Check if polybar cache directory exists
  if [ ! -d $HOME/.cache/polybar/ ]; then
    mkdir -p $HOME/.cache/polybar/
  fi

  # Ensure a config file exists for each bar and launch
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    f=$HOME/.cache/polybar/config_$m.ini
    createIfNotExist $f
    MONITOR=$m polybar -c $f --reload main &
    sed -i -e "s/pid = .*/pid = $!/g" $f
  done

# Otherwise, use default config file
else
  polybar -c $HOME/.config/polybar/config.ini --reload main &
fi

# Tell terminal that polybar launched
echo "Bars launched..."
