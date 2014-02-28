$computerList = .\4thFloorPCs.ps1
$computerList2 = .\5thFloorPCs.ps1
$computerList = $computerList + $computerList2
$computerList2 = .\6thFloorPCs.ps1
$computerList = $computerList + $computerList2
$computerList2 = .\7thFloorPCs.ps1
$computerList = $computerList + $computerList2
$computerList