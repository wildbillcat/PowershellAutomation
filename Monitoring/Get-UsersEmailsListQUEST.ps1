<#
.Synopsis
   Fetches account information of users in the supplied groups.
.DESCRIPTION
   Uses WMI to fetch all of the account names in groups specified using the QUEST toolkit
.EXAMPLE
   Template.ps1 -Groups "UserGroup1","UserGroup2","UserGroup3"
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>

Param(
    [Parameter(Mandatory=$true)]
    [string[]]$Groups = @("UserGroup1")
)


foreach($GroupName in $Groups){
    "Fetching $Group"
    $users = Get-QADGroupMember -Identity $GroupName
    
    foreach($user in $users){        
        $Email = $UserEntry = (get-QADUser $user).DirectoryEntry.mail
        
        "${user}; ${Email}; ${GroupName}; "
        "${FirstName}; ${LastName}; ${UserName}; ${Email}; ${Group}; $UserDN; ${AccountDisabled}" >> EmailQUESTHodgePodge.txt    
        }
}