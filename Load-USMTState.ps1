#REQUIRES -Version 4.0
#Should also have USMT installed
<#
.Synopsis
   This Copies USMT files onto the target computer, loads the specified store onto the computer
.DESCRIPTION
   This is a script that copies the local USMT program files onto the remote computer. It then 
   remotes into the machine and initiates a USMT load state, applying the previously captured files.
.EXAMPLE
   .\Load-USMTState.ps1 -MachineName Arch-PC-623 -USMTStorePath \\fileserver\usmtshare\arch-pc-623\ -USMTDecryptionKey key
.LINK
    mailto:patrick.mcmorran@yale.edu
#>

param(
   [Parameter(Mandatory=$TRUE, Position=0)] 
   [string]
   $MachineName,
   [Parameter(Mandatory=$TRUE, Position=1)] 
   [string]
   $USMTStorePath,
   [Parameter(Mandatory=$TRUE, Position=2)] 
   [string]
   $USMTDecryptionKey
   )

Copy-Item "C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\User State Migration Tool\amd64" "\\$MachineName\c$\USMT" -Recurse
Copy-Item $USMTStorePath "\\$MachineName\c$\USMTStore" -Recurse

Invoke-Command -ComputerName $MachineName -AsJob {
    Write-Output "Value of Key: $using:USMTDecryptionKey"
    C:\USMT\loadstate.exe "C:\USMTStore" /decrypt /key:"$using:USMTDecryptionKey"
}
