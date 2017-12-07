Get-Content d:\powerShell\domainGlobalGroups.txt | 
foreach-object {
New-QADGroup -name $_ -ParentContainer 'OC=Groups,OU=VDS,OU=Desktop Services,DC=bku,DC=DB,DC=DE}' -GroupScope Global
} 
