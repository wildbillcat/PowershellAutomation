<#
.Synopsis
   Fetches account information of users in the supplied groups.
.DESCRIPTION
   Uses WMI to fetch all of the account names in groups specified, then makes manual LDAP look ups to pull account information for each account, enabling compatibility for all AD versions and non AD domains.
.EXAMPLE
   Template.ps1 -Groups "Group1","Group2","Group3"
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>

Param(
    [Parameter(Mandatory=$true)]
    [string[]]$Groups = @("Group1")
)


foreach($GroupName in $TFSGroups){
    "Fetching $Group"
    $users = Get-ADGroupMember -Identity $Group -Recursive
    
    foreach($user in $users){
        $UserDN = $user.distinguishedName #Returns the Distinuished name, used for LADP querys. IE: CN=ALLAN.SALAVER,OU=Users,OU=IT-DIVISION,OU=Employees,OU=Users,OU=PRT,OU=Philippines,OU=SEA,OU=AIU,OU=R7,DC=r7-core,DC=r7,DC=aig,DC=net
        $adsiuser = [ADSI]"LDAP://$UserDN"
        $FirstName = ""
        if(!$user.givenName){
            $FirstName = $adsiuser.givenName
        }
        $LastName = ""
        if(!$user.sn){
            $LastName = $adsiuser.sn
        }
        $UserName = ""
        if($user.SamAccountName){
            $UserName = $user.SamAccountName
        }
        $Email = ""
        if($adsiuser.mail){
            $Email = $adsiuser.mail
        }
        $AccountDisabled = "False"
        if($adsiuser.AccountDisabled){
            $AccountDisabled = "True"
        }
        "${FirstName}; ${LastName}; ${UserName}; ${Email}; ${Group}; $UserDN; ${AccountDisabled}"
        "${FirstName}; ${LastName}; ${UserName}; ${Email}; ${Group}; $UserDN; ${AccountDisabled}" >> EmailHodgePodge.txt    
        }
}