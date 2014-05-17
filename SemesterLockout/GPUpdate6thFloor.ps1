$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=SOA 6th Floor Studio Workstations,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}
