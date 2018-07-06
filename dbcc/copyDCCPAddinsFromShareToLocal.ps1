cls
$EventlogName = 'Application'
$EventlogSource = 'DBCC Addin Copy'
$Source1 = '\\DE-BLNSVADBC001.bku.db.de\CCP_Clients_Software\Addins'
$Source2 = '\\DE-BLNSVADBC002.bku.db.de\CCP_Clients_Software\Addins'
$Destination = 'C:\ProgramData\DB Systel\DBCCAddins\'
if (Test-Path $Destination){
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination is exists"}
else {
 mkdir $Destination
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message "$Destination was created"}
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message 'Copy begining.'
if (Test-Path $Source1){
 $source = $Source1}
elseif (Test-Path $source2){
 $source = $Source2}
else{
 $Message = "Sources not found!"
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 3 -Message $Message
}
$Message =  'From ' + $source.ToString() + ' copy begin.'
Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
try{
 $lem = 0
 $CopyReturn = ""
 Copy-Item -Path $source -Destination $Destination -Force -Recurse -PassThru | foreach {$CopyReturn = $copyReturn + $_.Name + " + "; ($lem= $lem + 1);}
 $Message = "From Source $source to $Destination Files $CopyReturn copied. Summary $lem files copied."
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Information -EventId 1 -Message $Message
}
catch{
 $Message = "Unexpected Error: Files not copied! Source: " + $Source
 Write-EventLog -LogName $EventlogName -Source $EventlogSource -EntryType Error -EventId 2 -Message $Message
}
