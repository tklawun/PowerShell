Connect-QADService
New-QADGroup -Name 'TestGruppe1' -ParentContainer 'OU=Groups,DC=tklaw,DC=com' -GroupScope Global -Member 'Domänen-Benutzer'
New-QADGroup -Name 'TestGruppe3' -ParentContainer 'OU=Groups,DC=tklaw,DC=com' -GroupScope DomainLocal -Member 'TestGruppe1'