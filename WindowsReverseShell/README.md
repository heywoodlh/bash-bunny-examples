# Windows Persistent Reverse Shell for Bash Bunny

* Author: 0dyss3us (KeenanV) ** modified by heywoodlh
* Version: 1.3

## Description

Opens a reverse shell through Netcat on victim's Windows machine and connects it back to host attacker.
* Targets 64 bit Windows 10
* Deploys in roughly 15-20 seconds
* If desired, the reverse shell can be persistent

## Requirements

- Have a working Bash Bunny

## STATUS

| LED                  | STATUS                         |
| -------------------- | ------------------------------ |
| Purple               | Setup                          |
| Amber (Single Blink) | Installing and running scripts |
| Green                | Finished                       |

## Installation and Execution

### Staging:

1. Plug in Bash Bunny in arming mode
2. Move files from WindowsReverseShell to either switch folder
3. Edit the `run.ps1` file: edit the `$remoteServerIP`, `$remoteServerPort`, `$persistence` and `$volumeName` variables as desired
4. Unplug Bash Bunny and switch it to the position the payload is loaded on

### Attack:
1. Plug the Bash Bunny into your victim's Windows machine and wait until the final light turns green (about 15-20 seconds)
2. Unplug after the light turns green as the payload has been executed
3. On the remote attacking machine, set up a Netcat listener on the port you chose in the `run.ps1` file
   * Run the command `nc -nlvp 1337` (replace the port with the same in run.ps1)
4. A `cmd.exe` shell should appear

Notes: 
- If you set `$persistence` to 'True' in `run.ps1` then the script should always be running anytime the user is logged into their machine.
- The script should execute every minute so if it takes longer than a minute to connect then something is wrong.

## Discussion

For support or feedback on the original Windows persistent reverse shell [go here](https://forums.hak5.org/topic/42729-payload-windows-persistent-reverse-shell/)

For support or feedback on heywoodlh's modified version [go here](https://github.com/heywoodlh/bash-bunny-examples/issues)
