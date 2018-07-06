Clear-Host
$EventlogName = "Application"
$EventlogSource = "DBCC Addin Copy"
$Source = 'C:\ProgramData\DB Systel\DBCCAddins\Addins'
$Destination = 'C:\Program Files (x86)\Interactive Intelligence\ICUserApps\'
if (Test-Path $Destination -isvalid){
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination is exists"}
else {
mkdir $Destination
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination was created"}
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message 'Copy begining.'
try{
$lem = 0
$CopyReturn = ""
Copy-Item -Path $Source -Destination $Destination -Force -Recurse -PassThru | foreach {$CopyReturn = $copyReturn  + $_.Name + " + "; ($lem= $lem + 1);}
$Message = "From Source $Source to $Destination Files $CopyReturn copied. Summary $lem files copied."
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
}
catch
{
$Message = "Unexpected Error: Files not copied! "
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 2 -Message $Message
}
