$AppVPackagePfad=get-nivar "AppVPackageFullPath"
$AppVPackageFile = (Get-ChildItem $AppVPackagePfad -Filter *.appv).FullName
set-nivar "AppVPackageFile" $AppVPackageFile.ToString()
write-nireport "AppV File found: " $AppVPackageFile.ToString()
$AppVDeployementConfig = (Get-ChildItem $AppVPackagePfad -Filter *DeploymentConfig.xml).FullName
set-nivar "AppVDeployementConfig" $AppVDeployementConfig.ToString()
write-nireport "DeploymentConfig.xml found: " $AppVDeployementConfig 
$AppVUserConfig = (Get-ChildItem $AppVPackagePfad -Filter *UserConfig.xml).FullName
set-nivar "AppVUserConfig" $AppVUserConfig.ToString()
write-nireport "DeploymentConfig.xml found: " $AppVUserConfig.ToString()