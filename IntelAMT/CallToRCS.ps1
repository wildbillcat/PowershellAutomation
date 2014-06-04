param (  
    [Parameter(Mandatory=$TRUE, Position=0, HelpMessage="AMT BIOS Password")] 
    [string] 
    $AMTBiosPassword) 

$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=AssistantPC,OU=DM Office,OU=6th Floor,OU=Staff,OU=Client,OU=Architecture,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name


$AMTConfiguratorFiles = ".\AMTCFG\"

foreach($computer in $Batch.name){
    Copy-Item -Path $AMTConfiguratorFiles -Destination ("\\" + $computer + "\c$\")
    Get-ChildItem $AMTConfiguratorFiles | ForEach-Object { Copy-Item -Path $_.FullName -Destination ("\\" + $computer + "\c$\" + $AMTConfiguratorFiles) }
    invoke-expression -command ("Invoke-Command -ComputerName " + $computer + " { C:\AMTCFG\ACUConfig.exe NotifyRCS arch-cfgmgr.yu.yale.edu /AdminPassword " + $AMTBiosPassword + "}")
}



