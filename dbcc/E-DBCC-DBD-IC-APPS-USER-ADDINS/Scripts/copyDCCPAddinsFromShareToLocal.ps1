param(
[string] $basic_path1 = "\\de-blnsvadbc015\DBCC_Clientsoftware",
[string] $basic_path2 = "\\de-blnsvadbc016\DBCC_Clientsoftware"
)
cls
#--------------------------------------------------------------------------------------------------------------------------------------
#Variable Declaration
#--------------------------------------------------------------------------------------------------------------------------------------
$hostname = hostname
$EventlogName = 'Application'
$EventlogSource = 'DBCC Addin Copy'
$DefaultDestination = 'C:\ProgramData\DB Systel\DBCCAddins'
$DefaultSettings = 'DefaultSettings.xml'
$ClientSettings = $hostname + '_Settings.xml'
[boolean] $SetSyncEvent = $false
[string[]] $SrcPathComplete = @()
$options = @() 

#--------------------------------------------------------------------------------------------------------------------------------------
#Definition Class
#--------------------------------------------------------------------------------------------------------------------------------------
# Config Class for activating SyncJobs
class ClientJob
{
[string] $hostname
[string] $Sync
[string] $ActiveSyncJobs
}

# SyncJob Class to copy each SyncJob
class SyncJob
{
[int32] $Id
[string] $SrcHost
[string] $SrcPath
[string] $DstPath
[string] $CopyOptions
[Datetime] $CopyDate
}

#--------------------------------------------------------------------------------------------------------------------------------------
#Initiale Objects Client / CopyJob
#--------------------------------------------------------------------------------------------------------------------------------------
#Config
$c = [ClientJob]::new()
$c.hostname = hostname
$c.Sync = 'yes'
$c.ActiveSyncJobs = ''

#--------------------------------------------------------------------------------------------------------------------------------------
#Config validation, if config not present then exit the script
#--------------------------------------------------------------------------------------------------------------------------------------
# Testing Path to basic config
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message 'Checking server/config:'
if (Test-Path $basic_path1){
 $config_path = $basic_path1
 }
 elseif (Test-Path $basic_path2){
 $config_path = $basic_path2
 }
else{
 $Message = "Server not reachable!"
 Write-Host $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 3 -Message $Message
 exit 1
}
#--------------------------------------------------------------------------------------------------------------------------------------
#Validate Path
#--------------------------------------------------------------------------------------------------------------------------------------
#
if (!($config_path.EndsWith('\'))){
$config_path += '\' 
}

#--------------------------------------------------------------------------------------------------------------------------------------
#Reading Configs
#--------------------------------------------------------------------------------------------------------------------------------------
#Read basic config from server
if (Test-Path $config_path$DefaultSettings){
 [xml]$ConfigFile = Get-Content "$config_path$DefaultSettings"
  if($ConfigFile.Settings.ActiveSyncJobs){
   $c.ActiveSyncJobs = $ConfigFile | Select-XML -XPath "//ActiveSyncJobs[@Sync='yes']" 
  }
 $Message = "Basic config found. ActiveSyncJobs: " + $c.ActiveSyncJobs
 Write-Host $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
}
else{
 $Message = "Basic Config not found " + $config_path + $DefaultSettings
 Write-Host $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 3 -Message $Message
 exit 1
}

#Read client config from server
if (Test-Path $config_path$ClientSettings){
[xml]$ConfigFile = Get-Content "$config_path$ClientSettings"
    if($ConfigFile.Settings.ActiveSyncJobs){
    $c.ActiveSyncJobs = $ConfigFile | Select-XML -XPath "//ActiveSyncJobs[@Sync='yes']" 
    }
 $Message = "Client config found. ActiveSyncJobs: " + $c.ActiveSyncJobs
 Write-Host $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
}
else{
 $Message = "Client config not found"
 Write-Host $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 3 -Message $Message
}

#--------------------------------------------------------------------------------------------------------------------------------------
#Doing Syncjobs for Client
#--------------------------------------------------------------------------------------------------------------------------------------
#Get configured syncjobs for client

$c.ActiveSyncJobs.Split(" ") | ForEach-Object {
 
 # Get Syncjobs from Server
 $p = $config_path + 'syncjobs\' + $_
 if (Test-Path $p){
  [xml]$CopyJob = Get-Content $p
  $u = [SyncJob]::new()
  $u.SrcHost = $CopyJob.Job.SrcHost
  $u.SrcPath = $CopyJob.Job.SrcPath
  $u.DstPath = $CopyJob.Job.DstPath
  $u.CopyOptions = $CopyJob.Job.CopyOptions
  $u.CopyDate = Get-Date

   #Split host to array for robocopy and create share path
  $u.SrcHost.Split(" ") | ForEach-Object {
   $tmp = '\\' + $_ + $u.SrcPath
   $SrcPathComplete += $tmp
  }

  #Check destination directory
  if(!(Test-Path -Path $u.DstPath)){ 
    New-Item -ItemType directory -Path $u.DstPath
   }

   #Do robocopy for first reachable share in array
   $i=0
   [boolean] $SyncReachable=$FALSE
   while (($i -lt $SrcPathComplete.length) -and ($SyncReachable -eq $FALSE)){
   if(Test-Path -Path $SrcPathComplete[$i]){
    $SyncReachable=$TRUE
    $DstPath='"' + $u.DstPath + '"'
    $CopyArgs = @($SrcPathComplete[$i],$DstPath,$u.CopyOptions)
    Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message 'Copy begining.'
    $process = Start-Process -FilePath robocopy -ArgumentList $CopyArgs -Wait -NoNewWindow 
    }
    $i++
   }
  }
 else {
  $Message = 'Cannot read Jobfile: '+ $p 
  Write-Host -Object $Message
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 3 -Message $Message 
  Exit 1
 }
 $Message = 'Robocopy finish successfully | SyncJob: '+ $c.ActiveSyncJobs + ' | Dst: ' + $u.DstPath
 Clear-Variable -Name SrcPathComplete
 
#--------------------------------------------------------------------------------------------------------------------------------------
#Set synctoogle to true, if destinationpath in syncjob is "C:\ProgramData\DB Systel\DBCCAddins"
#--------------------------------------------------------------------------------------------------------------------------------------
 if($u.DstPath -eq $DefaultDestination){
 $SetSyncEvent = $TRUE
}
}

#--------------------------------------------------------------------------------------------------------------------------------------
# Write success event-id 10 to windows eventlog and trigger a systemscript to snyc the files to C:\Program Files (x86)\Interactive Intelligence\ICUserApps\
#--------------------------------------------------------------------------------------------------------------------------------------
if($SetSyncEvent){
 Write-Host -Object $Message
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 10 -Message $Message
}
