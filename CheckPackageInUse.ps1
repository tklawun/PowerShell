write-nireport "-----> CheckPackageInUse gestartet"
write-nireport "-----> Aktueller Benutzer: $env:USERNAME"
$AppVPackageName = "DBCC-17-ICUserApps-17.3-x86-Win7x86-v01"
write-nireport "-----> zu checken $AppVPackageName"
$AppvPackage = Get-AppvClientPackage -Name $AppVPackageName
if ($AppvPackage.count -gt 0)
    {
    write-nireport "-----> $AppVPackageName gestartet --> $($AppVPackage.InUse)"
    set-nivar "AppVPackageInuse" "$($AppvPackage.InUse)"
    write-nireport "-----> CheckPackageInUse beendet"
    }
Else
    {
    write-nireport "-----> Anwendung nicht vorhanden"
    }