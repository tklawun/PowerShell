cls
Get-Content d:\powerShell\computerList.txt | foreach-object {
 Stop-Computer -ComputerName $_ -Force
}