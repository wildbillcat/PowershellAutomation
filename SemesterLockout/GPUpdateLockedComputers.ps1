$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=SOA 4th Floor Studio Workstations - No Access,OU=SOA 4th Floor Studio Workstations,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}
$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=SOA 5th Floor Studio Workstations - No Access,OU=SOA 5th Floor Studio Workstations,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}
$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=SOA 6th Floor Studio Workstations - No Access,OU=SOA 6th Floor Studio Workstations,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}
$Batch =  Get-ADComputer -Filter * -Properties Name -SearchBase "OU=SOA 7th Floor Studio Workstations - No Access,OU=SOA 7th Floor Studio Workstations,OU=Lab Computers,OU=Architecture,DC=yu,DC=yale,DC=edu" | select name
Invoke-Command -ComputerName $Batch.name { gpupdate /force}