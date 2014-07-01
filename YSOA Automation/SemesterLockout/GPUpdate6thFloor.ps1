$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=6th Floor Lab,OU=Teaching Labs,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}
