<#
.Synopsis
   This script can be used as a scheduled task to delete logs, etc.
.DESCRIPTION
   This file is meant to be used to delete log files, and any other old content that it runs into.
.EXAMPLE
   powershell.exe -file Remove-Files.ps1 -Path "C:\IIS\Logs" -Days 4 
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>
Param(
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [Parameter(Mandatory=$true)]
    [int]$Days
)

$limit = (Get-Date).AddDays(-1*$Days)

Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force