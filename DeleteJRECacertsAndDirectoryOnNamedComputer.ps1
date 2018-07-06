#Löscht die drei Java Schluessel-Speicher-Datei cacerts
#Thomas Klawun, DB Systel
#Datei ComputerListe.txt liegt im gleichen Verzeichnis wie das Skript. Einfache Computerliste
$ThisScriptPath = Split-Path $($MyInvocation.InvocationName) -Parent
foreach($computer in (get-content $ThisScriptPath\ComputerListe.txt)) {
Try{
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Start auf $computer"
if (Test-Connection -computername $computer -quiet){
if (test-path "\\$computer\C$\Program Files (x86)\Java\jre1.8.0_151" -IsValid){
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Beginne mit Verzeichnis 1 gelöscht auf $computer"
Remove-Item "\\$computer\C$\Program Files (x86)\Java\jre1.8.0_151" -Force -Recurse
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Verzeichnis 1 gelöscht"
}
else {
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Verzeichnis 1 auf $computer nicht vorhanden."
}
if (test-path "\\$computer\C$\Program Files (x86)\Java\jre1.8.0_161" -IsValid){
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Beginne mit Verzeichnis 2 gelöscht auf $computer"
Remove-Item "\\$computer\C$\Program Files (x86)\Java\jre1.8.0_161" -Force -Recurse
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Verzeichnis 2 gelöscht auf $computer"
}
else {
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Verzeichnis 2 auf $computer nicht vorhanden."
}
if (test-path "\\$computer\C$\Windows\Sun\Java\Deployment\deutschebahn\security" -IsValid){
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Beginne mit Verzeichnis 3 gelöscht auf $computer"
Remove-Item "\\$computer\C$\Windows\Sun\Java\Deployment\deutschebahn\security" -Force -Recurse
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject  "Verzeichnis 3 gelöscht auf $computer"
}
else {
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Verzeichnis 3 auf $computer nicht vorhanden."
}
}
else {
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "$computer nicht vorhanden/online."
}
}
 catch{
Out-File -FilePath "$ThisScriptPath\ergebnis.txt" -Append unicode -InputObject "Es ist ein Fehler auf $computer aufgetreten. Bitte prüfen!"
 }
}
