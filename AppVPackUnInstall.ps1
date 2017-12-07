$AppVPackageName = "DBCC-17-ICUserApps-17.3-x86-Win7x86-v01"
Import-Module AppVClient
write-nireport "---->App-V Client Modul importiert"

$AppvPackage = Get-AppvClientPackage -Name $AppVPackageName
if ($AppvPackage.count -gt 0)
    {
    Stop-AppvClientPackage -Global -PackageId $AppvPackage.PackageId -VersionId $AppvPackage.VersionId
    write-nireport "---->App-V Package gestoppt $($AppvPackage.Name)"
    Unpublish-AppvClientPackage -Global -PackageId $AppvPackage.PackageId -VersionId $AppvPackage.VersionId
    write-nireport "---->App-V Package Veröffentlichung entfernt $($AppvPackage.Name)"
    Remove-AppvClientPackage -PackageId $AppvPackage.PackageId -VersionId $AppvPackage.VersionId
    write-nireport "---->App-V Package entfernt  $($AppvPackage.Name)"
    }
Else
    {
    write-nireport "-----> Anwendung nicht vorhanden"
    }