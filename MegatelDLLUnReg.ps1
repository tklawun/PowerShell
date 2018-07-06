$AppvPackage = Get-AppvClientPackage -name E-MSAPPV-51-MEGATEL-v01
$ExecuteFile = "regsvr32.exe"
$Argument = "C:\Windows\SysWOW64\msstdfmt.dll /u /s"
Start-AppvVirtualProcess -FilePath $ExecuteFile -ArgumentList $Argument -AppvClientObject $AppvPackage