Clear-Host
$FileSource = "D:\PowershellSkripte\dbcc\copyDCCPAddinsFromLocalToProgramFiles.ps1"
$computercollection = Get-Content -Path "D:\PowershellSkripte\dbcc\ListOfComputer4.txt"
$LogPCFileNotFound = "D:\PowershellSkripte\dbcc\CopyPCNotFound.txt"
$logPCFound = "D:\PowershellSkripte\dbcc\CopyPCFound.txt"
$logPCNotOnline = "D:\PowershellSkripte\dbcc\CopyPCNotOnline.txt"
set-content -path $LogPCFileNotFound -Value "File not founded!"
set-content -path $logPCFound -Value "File founded!"
set-content -path $logPCNotOnline -Value "Computer Not online!"
foreach ($Computer in $computercollection) {
    $fileDestination = "\\$Computer\c$\Program Files (x86)\DB Systel\E-DBCC-IC-APPS-USER-ADDINS\Scripts\copyDCCPAddinsFromLocalToProgramFiles.ps1"
    if (Test-Connection -ComputerName $Computer -Quiet) {
        if (Test-Path -Path $fileDestination) {
            copy-item -Path $FileSource -Destination $fileDestination -Force
            write-host "$computer found, file copied" 
            add-content -path $logPCFound -value $Computer
        }
        else {
            add-content -path $LogPCFileNotFound -value $Computer
            write-host $computer " file not found, file not copied"
        }
    }
    else {
      write-host "$computer not online"
      Add-Content -value $Computer -path $logPCNotOnline
    }
}



