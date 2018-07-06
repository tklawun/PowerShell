
if ((Get-EventLog -LogName Application -Source "DBCC Addin Copy").count > 0){
write-eventlog -LogName Application -Source "DBCC Addin Copy" -EntryType Information -EventId 1 -Message "Eventlog Source is exists and is ready for writing"
}
else {
$ergebnis = New-EventLog -LogName Application -Source "DBCC Addin Copy"
write-eventlog -LogName Application -Source "DBCC Addin Copy" -EntryType Information -EventId 1 -Message "created Eventlog and is ready for writing"
}     
