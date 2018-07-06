Clear-Host
$EventlogName = "Application"
$EventlogSource = "DBCC Addin Copy"
$Source = 'C:\ProgramData\DB Systel\DBCCAddins\Addins'
$Destination = 'C:\Program Files (x86)\Interactive Intelligence\ICUserApps\Addins'
$DeleteFlag = '\deleteAddins'
$CopyArgsSource = "`"" + $Source + "`""
$CopyArgsDestination = "`"" + $Destination + "`""
$CopyArgs = @($CopyArgsSource,$CopyArgsDestination,"`"/R:3`"","`"/W:5`"","`"/MIR`"")
$ICUserApps = 'InteractionDesktop'


if (Test-Path $Source$DeleteFlag){
Remove-Item -Path $Destination -Force -Recurse
$Message = "DBCCAddinsFromLocalToProgramFiles: Deleting DBCC Addins finished"
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
exit 0
}

if (Test-Path $Source){
 if (Test-Path $Destination){
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination is exists"
  }
 else {
  mkdir $Destination
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination was created"
  }
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message 'Copy begining.'
  
 # Warte bis Interaction Desktop beendet wird. 
 $p = Get-Process $ICUserApps
 if(!($p -eq $null)){
  Wait-Process -InputObject $p
 }

 try{
  $process = Start-Process -FilePath robocopy -ArgumentList $CopyArgs -Wait -NoNewWindow 
  #robocopy $Source $Destination "/R:3" "/W:5" "/XO" "/MIR" "/log:`"D:\TMP\RobocopytoProgramFiles.log`""
  $Message = "DBCCAddinsFromLocalToProgramFiles: From Source $Source to $Destination copied."
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
 }
 catch
 {
  $Message = "Unexpected Error: Files not copied! "
  Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 2 -Message $Message
 }
}
else{
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Warning -EventId 3 -Message "$source not exists. Repeat next login."}
 