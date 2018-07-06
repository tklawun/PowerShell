Set-AppvClientConfiguration -EnablePackageScripts $true
Add-AppvClientPackage -Path D:\AppVPacks\E-MSAPPV-51-MEGATEL-v01\E-MSAPPV-51-MEGATEL-v01_1.appv -DynamicDeploymentConfiguration D:\AppVPacks\E-MSAPPV-51-MEGATEL-v01\E-MSAPPV-51-MEGATEL-v01_1_DeploymentConfig.xml | Publish-AppvClientPackage -Global | Mount-AppvClientPackage
