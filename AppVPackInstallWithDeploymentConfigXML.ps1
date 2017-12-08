Import-Module AppVClient
$AppVFile = "D:\AppVPack\HoD-12-JRT131-x32-Win7x64-v02\HoD-12-JRT131-x32-Win7x64-v02.appv"
$ConfigurationXML = "D:\AppVPack\HoD-12-JRT131-x32-Win7x64-v02\HoD-12-JRT131-x32-Win7x64-v02_DeploymentConfigHoDAbn.xml"
Add-AppvClientPackage -Path $AppVFile -DynamicDeploymentConfiguration $ConfigurationXML | Mount-AppvClientPackage | Publget-servicish-AppvClientPackage -Global
