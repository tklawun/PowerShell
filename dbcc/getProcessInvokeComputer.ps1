#$cred = Get-Credential
$FileSource = "D:\PowershellSkripte\dbcc\copyDCCPAddinsFromLocalToProgramFiles.ps1"
$computercollection = Get-Content -Path "D:\PowershellSkripte\dbcc\ListOfComputer.txt"
$logdatei = "D:\PowershellSkripte\dbcc\CopyFileLog.txt"
Set-Content -path $logdatei -Value "Neuer Versuch " + (get-date).ToShortDateString() + (get-date).ToShortTimeString()
foreach ($Computer in $computercollection) {
  $fileDestination = "\\$Computer\c$\DB Systel\E-DBCC-IC-APPS-USER-ADDINS\Scripts\copyDCCPAddinsFromLocalToProgramFiles.ps1"
  if (Test-Path -Path $fileDestination) {
    copy-item -Path $FileSource -Destination $fileDestination -Force | Add-Content -Path $logdatei
    write-host $computer  + " found, file copied"
  }
  else {
    $Computer + " not online" | Add-Content -path $logdatei
    write-host $computer  + " not found, file not copied"
  }
 }


