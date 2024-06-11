# TimeBomb
```
___________.__              __________              ___.
\__    ___/|__| _____   ____\______   \ ____   _____\_ |__
  |    |   |  |/     \_/ __ \|    |  _//  _ \ /     \| __ \
  |    |   |  |  Y Y  \  ___/|    |   (  <_> )  Y Y  \ \_\ \
  |____|   |__|__|_|  /\___  >______  /\____/|__|_|  /___  /
                    \/     \/       \/             \/    \/
```
## Overview
TimeBomb is a simple and customizable timer script written in Bash. It allows you to set a timer with a specified duration and an optional custom message that will be displayed when the timer goes off. Additionally, the script provides a visual progress bar and desktop notification using the notify-send command.


## Features
- Customizable timer duration.
- Optional custom reminder message.
- Visual progress bar.
- Desktop notification when the timer completes.
- Dependency on libnotify-bin for notifications.

## License
- TimeBomb is released under the MIT License. See the full license text in the script or below:

## Usage
  ```
  timebomb [-m|--message <custom_message>] [-d|--duration <total_time>] [-h|--help]
  ```
Options
-m, --message <custom_message>: Customize the reminder message.
-d, --duration <total_time>: Set the total duration of the timer. You can also set the duration without any option.
-h, --help: Print the help message.

### Examples
Set a timer for 5 minutes with a custom message:
 
  ``` 
  ./timebomb.sh -d 5m -m "Time's up! Take a break." 
  ```
Set a timer for 30 seconds without a custom message:

  ```
  ./timebomb.sh 30s
  ```

Display the help message:

  ```
  ./timebomb.sh -h
  ```

Dependencies
TimeBomb requires the libnotify-bin package to display desktop notifications. You can install it using your package manager. For example, on Debian-based systems:

  ``` 
  sudo apt-get install libnotify-bin
  ```

## Contact
TimeBomb was created by Abdullah Ozer.
For more information or support, please contact Abdullah Ozer at abdullahozer11@hotmail.com.
