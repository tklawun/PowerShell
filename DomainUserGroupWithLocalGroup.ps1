CLS
Connect-QADService
$acatgroup = "ga-AppV-OFFICE2003"
New-QADGroup -name $acatgroup -samaccountname $acatgroup -ParentContainer 'OU=Groups,OU=VDS,OU=Desktop Services,DC=bku,DC=db,DC=de' -GroupScope Global -Member 'bku\thomasklawun','bku\thomasklawun01','bku\thomasklawun02','bku\thomasklawun03','bku\thomasklawun04','bku\thomasklawun05','bku\thomasklawun06'
$glob = $acatgroup-creplace ('ga','da')
$member = 'bku\'+$acatgroup
New-QADGroup -name $glob -samaccountname $glob -ParentContainer 'OU=Groups,OU=VDS,OU=Desktop Services,DC=bku,DC=db,DC=de' -GroupScope DomainLocal -Member $member
	