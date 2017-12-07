Import-Module AppVClient
$ExecutionDirectory = Get-Location
$AppVPackageFile = (Get-ChildItem $ExecutionDirectory -Recurse -Filter *.appv).FullName
#Write-Host $AppVPackageFile
write-nireport "----> App-V Client Modul importiert"
write-nireport "----> App-V Package gefunden: $AppVPackageFile"
Add-AppvClientPackage -Path $AppVPackageFile | Mount-AppvClientPackage | Publish-AppvClientPackage -Global
write-nireport "----> App-V Package hinzugefügt DBCC-17-ICUserApps-17.3-x86-Win7x86-v01.appv"
