pkgs:

pkgs.writeShellScript "swww.sh" ''
  # Check for at least two arguments
  if [ $# -lt 2 ]; then
      echo "Usage: $0 <path-to-img-1> <path-to-img-2> ..."
      exit 1
  fi

  # Set the wallpaper to start
  swww img "${1}" --transition-type none

  # This controls (in seconds) when to switch to the next image
  INTERVAL=300

  while true; do
      # Get the current hour (24-hour format)
      current_hour=$(date +"%H")

      # Pick an image based on the time of day
      if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 9 ]; then
          # Morning: 6am - 8:59am
          img="${1}"
      elif [ "$current_hour" -ge 9 ] && [ "$current_hour" -lt 17 ]; then
          # Day: 10am - 4:59pm
          img="${2}"
      elif [ "$current_hour" -ge 17 ] && [ "$current_hour" -lt 20 ]; then
          # Evening 5pm - 7:59pm
          img="${3}"
      else
          # Night: 8pm - 5:59am
          img="${4}"
      fi

      # Set the wallpaper using swww
      swww img "${img}" \
                  --transition-type fade \
                  --transition-step 1 \
                  --transition-fps 255
    
      # Sleep for the specified interval
      sleep "$INTERVAL"
  done
''
