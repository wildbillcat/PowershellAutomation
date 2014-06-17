#Wrote this to move an IP address from one NIC to another NIC, without having to install java and roll back IE just to use the DRAC lights out management of my server.
pause

Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp

##Requires Confirmation, will have to look into it
##http://technet.microsoft.com/en-us/library/jj130903.aspx
Disable-NetAdapter -Name "Ethernet"

##Requires Confirmation, will have to look into it
##http://technet.microsoft.com/en-us/library/jj130903.aspx
Enable-NetAdapter -Name "Ethernet 2"

New-NetIPAddress –InterfaceAlias “Ethernet 2” –IPv4Address “ip address” –PrefixLength 24 -DefaultGateway 172.29.106.1

Set-DnsClientServerAddress -InterfaceAlias “Ethernet 2” -ServerAddresses 130.132.1.10, 130.132.1.11

pause