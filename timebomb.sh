#!/bin/bash
# Copyright 2024 Abdullah OZER
############################################################
# Help                                                     #
############################################################

Help()
{
   echo "Welcome to TimeBomb, create a custom timer with duration and optional message."
   echo
   echo "___________.__              __________              ___."
   echo "\\__    ___/|__| _____   ____\\______   \\ ____   _____\\_ |__"
   echo "  |    |   |  |/     \\_/ __ \\|    |  _//  _ \\ /     \\| __ \\"
   echo "  |    |   |  |  Y Y  \\  ___/|    |   (  <_> )  Y Y  \\ \\_\\ \\"
   echo "  |____|   |__|__|_|  /\\___  >______  /\\____/|__|_|  /___  /"
   echo "                    \\/     \\/       \\/             \\/    \\/"
   echo ""
   echo
   echo "Syntax: timebomb [-m|--message <custom_message>] [-d|--duration <total_time>] [-h|--help]"
   echo "options:"
   echo "-m, --message <custom_message>  Customize reminder message."
   echo "-d, --duration <total_time>     Set the total duration of the timer."
   echo "                                 You may set the total duration without any option."
   echo "-h, --help                      Print this Help."
   echo
   echo "Dependency: libnotify-bin"
   echo
   echo "All rights reserved to ApoJean."
   echo "For more information or support, please contact: abdullahozer11@hotmail.com"
   echo
}

# Check if notify-send command exists
if ! command -v notify-send &> /dev/null
then
    echo "notify-send command not found. Please install libnotify-bin package."
    exit 1
fi

# Check if no parameters are given, activate HELP
if [ "$#" -eq 0 ]; then
    Help
    exit 0
fi

# Check if the first argument is a valid duration
if [[ "$1" =~ ^[0-9]+[smh]$ ]]; then
    DURATION="$1"
    shift
fi


TEMP=$(getopt -o hm:d: --long help,message:,duration: -n 'timebomb' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

HELP=false
MESSAGE="Your timer just went off. Wake up !!!"
while true; do
  case "$1" in
    -h | --help ) HELP=true; shift ;;
    -m | --message ) MESSAGE="$2"; shift 2 ;;
    -d | --duration ) DURATION="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# If -h or --help option is specified, display help and exit
if $HELP ; then
    Help
    exit 0
fi

# Get the total_time
if [ -n "$DURATION" ]; then
    total_time_raw=$DURATION
else
    # If no -d option, assume the duration is at the end
    total_time_raw=$1
    shift
fi

update_interval=1  # update interval for the loading bar in seconds
progress_char="#"  # character used for the loading bar

unit="${total_time_raw: -1}"
remaining="${total_time_raw:0:-1}"

unit=$(echo "$unit" | tr '[:upper:]' '[:lower:]')  # Convert unit to lowercase

# Convert total_time_raw based on the unit
if [ "$unit" == "s" ]; then
    total_time=$((10#$remaining))
elif [ "$unit" == "m" ]; then
    total_time=$((10#$remaining * 60))
elif [ "$unit" == "h" ]; then
    total_time=$((10#$remaining * 3600))
else
    total_time=$((10#$total_time_raw))
fi

for ((i = 1; i <= total_time; i += update_interval)); do
    # Sleep for the update interval
    sleep $update_interval

    # Calculate progress percentage
    progress=$((i * 100 / total_time))
    printf "[%-100s] %d%%" "$(printf "%-${progress}s" "$progress_char" | sed 's/ /\#/g')" "$progress"

    # Move the cursor to the beginning of the line
    printf "\r"

done

# Print a newline to separate the loading bar from the "Done" message
echo ""

# Print "Done" message
echo "$MESSAGE"

# Display a notification
notify-send "$MESSAGE"
