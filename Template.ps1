#REQUIRES -Version 4.0
#REQUIRES –runasadministrator
#REQUIRES -Module WebAdministration
#REQUIRES -Module xWebAdministration
<#
.Synopsis
   Quick Summary of script
.DESCRIPTION
   Detailed description of all the various things the script may do.
.EXAMPLE
   Template.ps1 -ComputerName PC1,PC2,PC3 
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>
Param(
    [Parameter(Mandatory=$true)]
    [string[]]$ComputerName
)


foreach($Computer in $ComputerName){
        #Do Something
}
