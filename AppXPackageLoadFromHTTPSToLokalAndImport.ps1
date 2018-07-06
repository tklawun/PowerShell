$webclient = New-Object System.Net.WebClient
$downloadedAppXFile = "$env:TEMP\NotepadPlPl756x86v01.appx"
$webclient.DownloadFile("https://klawun.com/AppXPackage/NotepadPlPl756x86v01.appx", $downloadedAppXFile)
Add-AppxPackage $downloadedAppXFile
