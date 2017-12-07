Import-Module AppVClient
$AppVPackgageName = "DBCC-17-ICUserApps-17.3-x86-Win7x86-v01"
$AppvPackage = Get-AppvClientPackage -Name $AppVPackgageName
set-nivar "AppVPackageInstalled" $AppvPackage.count