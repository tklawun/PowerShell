#$cred = Get-Credential
$FileSource = "D:\PowershellSkripte\dbcc\copyDCCPAddinsFromLocalToProgramFiles.ps1"
$computercollection = Get-Content -Path "D:\PowershellSkripte\dbcc\ListOfComputer1.txt"
$logdatei = "D:\PowershellSkripte\dbcc\CopyFileLog.txt"
$logPCNotFound = "D:\PowershellSkripte\dbcc\CopyPCNotFound.txt"
$logPCFound = "D:\PowershellSkripte\dbcc\CopyPCFound.txt"
Set-Content -path $logdatei -Value "Neuer Versuch "#(get-date).ToShortDateString() (get-date).ToShortTimeString()
set-content -path $logPCNotFound -Value "File not founded!"
set-content -path $logPCFound -Value "File founded!"
foreach ($Computer in $computercollection) {
  $fileDestination = "\\$Computer\c$\Program Files (x86)\DB Systel\E-DBCC-IC-APPS-USER-ADDINS\Scripts\copyDCCPAddinsFromLocalToProgramFiles.ps1"
  if (Test-Path -Path $fileDestination) {
    copy-item -Path $FileSource -Destination $fileDestination -Force
    write-host "$computer found, file copied" 
    add-content -path $logdatei -Value "$computer found, file copied" 
    add-content -path $logPCFound -value $Computer
  }
  else {
    Add-Content -path $logdatei -value "$Computer  not online" 
    add-content -path $logPCNotFound -value $Computer
    write-host $computer " not found, file not copied"
  }
 }



