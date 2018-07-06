$AppvPackage = Get-AppvClientPackage -name E-MSAPPV-51-MEGATEL-v01
$AppvPackage
$ExecuteFile = "regsvr32.exe"
$Argument = "C:\Windows\SysWOW64\msstdfmt.dll"
Start-AppvVirtualProcess -FilePath $ExecuteFile -ArgumentList $Argument  -AppvClientObject $AppvPackage
