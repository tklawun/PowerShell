Connect-QADService
Get-Content d:\powerShell\domainGlobalGroups.txt | foreach-object {
	New-QADGroup -name $_ -samaccountname $_ -ParentContainer 'OU=Groups,OU=VDS,OU=Desktop Services,DC=bku,DC=db,DC=de' -GroupScope Global -Member 'bku\ga-VDS-User'
	$glob = $_-creplace ('ga','da')
	$member = 'bku\'+$_
	New-QADGroup -name $glob -samaccountname $glob -ParentContainer 'OU=Groups,OU=VDS,OU=Desktop Services,DC=bku,DC=db,DC=de' -GroupScope DomainLocal -Member $member
} 

