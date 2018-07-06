Copy-Item -Path $env:TEMP -Destination D:\Temp -Recurse -PassThru | foreach {write-host $_.Name; ($lem= $_.length/1kb);}
write-host $lem