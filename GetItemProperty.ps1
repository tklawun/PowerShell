Clear-Host
$test = (Get-ItemProperty -Path C:\AsesClient\jre1.8.0_171\bin\java.exe).LastWriteTime
$test1 = (Get-ItemProperty -Path C:\AsesClient\jre1.8.0_171\bin\java.exe).FullName
$test2 = (Get-ItemProperty -Path C:\AsesClient\jre1.8.0_171\bin\java.exe).
Write-Host $test
Write-Host $test1

 