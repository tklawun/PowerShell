$AppVPackages = Get-AppvClientPackage
foreach ($AppvPackage in $AppVPackages){
    Mount-AppvClientPackage $AppvPackage
    $percentLoaded = ($AppvPackage).PercentLoaded
    $percentLoaded
}