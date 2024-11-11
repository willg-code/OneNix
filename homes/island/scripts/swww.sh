#!/bin/sh

# Check for at least two arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <path-to-switch-script> <path-to-img-1> <path-to-img-2> ..."
    exit 1
fi

# Extract the path to the switch script and images
SWITCH_SCRIPT="$1"
shift

# This controls (in seconds) when to switch to the next image
INTERVAL=300

while true; do
    # Get the current hour (24-hour format)
    current_hour=$(date +"%H")

    # Pick an image based on the time of day
    if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 12 ]; then
        # Morning: 6am - 11:59am
        img="${1}"
    elif [ "$current_hour" -ge 12 ] && [ "$current_hour" -lt 18 ]; then
        # Afternoon: 12pm - 5:59pm
        img="${2}"
    elif [ "$current_hour" -ge 18 ] && [ "$current_hour" -lt 24 ]; then
        # Evening 6pm - 12am
        img="${3}"
    else
        # ENight: 6pm - 5:59am
        img="${4}"
    fi

    # Set the wallpaper using swww
    swww img "${img}" \
                --transition-step 1 \
                --transition-duration 1 \
                --transition-fps 255
    
    # Sleep for the specified interval
    sleep "$INTERVAL"
done
