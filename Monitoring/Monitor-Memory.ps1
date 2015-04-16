#REQUIRES -Version 3.0
#REQUIRES –runasadministrator
<#
.Synopsis
   Monitor's Memory of a Host and sends warning e-mail when threshold is passed
.DESCRIPTION
   This script runs as a scheduled task, periodically checking if free memory has gone below the threshold. Must be run as an administrator.
   Practical use of this is for the creation of a Windows Scheduled Task, with the below commandline used and run as administrator. The Task
   frequency should be how often the system should be checked.
.EXAMPLE
   powershell.exe -file "Path\To\Monitor-Memory.ps1" -EmailTo "SupportWarning@server.com" -FreeMemoryThresholdBytes 4302204928
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>

Param(
    [Parameter(Mandatory=$true)]
    [long]$FreeMemoryThresholdBytes = 4302204928,

    [Parameter(Mandatory=$true)]
    [string]$EmailTo = "email@site.com",

    [Parameter(Mandatory=$true)]
    [string]$SMTP = "smtp.server.com"
)

$FreeMemory = (Get-Counter "\Memory\Available Bytes").CounterSamples[0].CookedValue

if($FreeMemory -le $FreeMemoryThresholdBytes){
    $From = "$env:COMPUTERNAME@server.org"
    $Message = "Warning, this server $env:COMPUTERNAME has used all but $FreeMemory"

    $logFileExists = Get-EventLog -LogName Application -Source “Monitor-Memory.ps1”
    if ($null -eq $logFileExists) {
        #Creates ability to write in the Event Log if Script havs never been triggered before.
        New-EventLog –LogName Application –Source “Monitor-Memory.ps1”
        "Created Event Log Monitor-Memory.ps1"
    }
    #Makes Note in event log of condition for PostOp
    Write-EventLog –LogName Application –Source “Monitor-Memory.ps1” –EntryType Error –EventID 1 –Message “Free Memory is now at: $FreeMemory, threshold is $FreeMemoryThresholdBytes”
    Send-MailMessage -From $From -To $EmailTo -Subject "Server Memory Warning!" -SmtpServer "$SMTP" -Body $Message
}