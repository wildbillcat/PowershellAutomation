#requires -version 2 
<#  
.Synopsis  
    Prepares a virtual machine for use with Remote Desktop Virtualization. 
     
.Description  
    This script configures the operating system on the virtual machine to work with Remote Desktop Virtualization. It performs following activities: 
     
        1. It enables Remote Desktop. 
        2. It enables Remote Procedure Call (RPC). 
        3. It adds users to the Remote Desktop Users group. 
        4. Adds the Remote Desktop Virtualization Host server to the permissions list for the RDP-Tcp listener. 
        5. Enable Windows Firewall to allow an exception for Remote Desktop Services. 
        6. Enable Windows Firewall to allow an exception for Remote Service Management 
        7. Restarts the Remote Desktop Services service or reboots the virtual machine. 
     
    Note : Elevated permissions are required to execute this script. 
           Cross-domain scenarios are supported by this script. 
     
.Parameter RDVHost 
    One or more RD Virtualization Host servers that will host the virtual machine. Should follow domain\machine format. 
     
.Parameter RDUsers 
    Names of the users or user groups to add to the Remote Desktop Users group. Should follow domain\groupname format. 
     
.Parameter DoNotRestartService 
    Optional parameter not to restart the Remote Desktop Services service. 
     
.Parameter LogFile 
    Optional parameter to specify a file to log events. Default logfile location is '.\Configure-VirtualMachine.log'. 
     
.Example  
    PS C:\> Configure-VirtualMachine.ps1 -RDVHost testdomain\Host1, testdomain\Host2 
     
    This example configures the virtual machine to run on the RD Virtualization Host servers Host1 and Host2 and restarts the Remote Desktop Services service. 
     
.Example  
    PS C:\> Configure-VirtualMachine.ps1 -RDVHost testdomain\Host1, testdomain\Host2 -LogFile C:\RDVsetup.log 
     
    This example configures the virtual machine to run on the RD Virtualization Host servers Host1 and Host2 and restarts the Remote Desktop Services service. Events are logged in the file 'C:\tsvsetup.log'. 
     
.Example  
    PS C:\> Configure-VirtualMachine.ps1 -RDVHost testdomain\Host1, testdomain\Host2 -RDUsers testdomain\usergroup1, testdomain\usergroup2 
     
    This example configures the virtual machine to run on the RD Virtualization Host servers Host1 and Host2 and adds usergroup1 and usergroup2 to the Remote Desktop Users group and restarts the Remote Desktop Services service. 
     
.Example  
    PS C:\> Configure-VirtualMachine.ps1 -RDVHost testdomain\Host1 -RDUsers testdomain\usergroup1, testdomain\usergroup2 -DoNotRestartService 
     
    This example configures the virtual machine to run on the RD Virtualization Host server Host1 and adds usergroup1 and usergroup2 to the Remote Desktop Users group. It does not restart the Remote Desktop Services service. 
 
.Example  
    PS C:\> Configure-VirtualMachine.ps1 -RDVHost testdomain\Host1 -RDUsers testdomain\usergroup1, testdomain\usergroup2 -DoNotRestartService -Force 
     
    This example configures the virtual machine to run on the RD Virtualization Host server Host1 and adds usergroup1 and usergroup2 to the Remote Desktop Users group. It does not restart the Remote Desktop Services service and does not validate the users and RD virtualization host server. 
 
.Notes  
    Name     : Configure-VirtualMachine.ps1  
     
#> 
 
param ( 
    [ValidatePattern("(.+)\\(.+)")] 
    [Parameter(Mandatory=$TRUE, Position=0, HelpMessage="RD Virtualization Host server")] 
    [string[]] 
    $RDVHost, 
 
    [ValidatePattern("(.+)\\(.+)")] 
    [Parameter(Mandatory=$FALSE, Position=1, HelpMessage="Remote Desktop Users")] 
    [string[]] 
    $RDUsers, 
 
    [Parameter(Mandatory=$FALSE, Position=2, HelpMessage="File to which events are to be logged")] 
    [string] 
    $LogFile = ".\Configure-VirtualMachine.log", 
     
    [Parameter(Mandatory=$FALSE, HelpMessage="Option not to restart the Remote Desktop Services service")] 
    [switch] 
    $DoNotRestartService, 
 
    [Parameter(Mandatory=$FALSE, HelpMessage="Option to ignore verification of object when credentials are not valid")] 
    [switch] 
    $Force 
) 
 
function Write-Log ([string]$Message = "", [string]$Type = "verbose") 
{ 
    switch ($Type) 
    { 
        "error"       {Write-Error $Message} 
        "warning"     {Write-Warning $Message} 
        "verbose"     {Write-Verbose $Message} 
        "host"        {Write-Host $Message} 
        "initialize"  { "" > $LogFile; return } 
    } 
     
    $Message >> $LogFile 
} 
 
#   Check if the script is running with administrator/elevated privileges 
function Check-Credentials 
{ 
    $principal = New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent()) 
    $elevated = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)   
 
    if (-not $elevated) 
    { 
        Write-Error "Please run this script in an elevated shell!" 
        exit 1 
    } 
} 
 
function Grant-RDPPermissions([String]$RDVHost, [bool]$isXP = $FALSE) 
{ 
    $adsiPath = "WinNT://{0}/{1}" -f ($RDVHost -split "\\") 
    if ((([ADSI]$adsiPath).Class -ne "Group") -AND ($vhost -notmatch '\$$')) 
    { 
        $RDVHost = "$RDVHost$" 
    } 
 
    $nameSpace = if ($isXP) {"root\cimv2"} else {"root\cimv2\terminalservices"} 
 
    $tsAccounts = @(Get-WMIObject -Namespace $nameSpace -Query "SELECT * FROM Win32_TSAccount WHERE (TerminalName = 'RDP-TCP' OR TerminalName = 'Console') AND AccountName = '$($RDVHost.replace("\", "\\"))'") 
 
    if ($tsAccounts -eq $NULL -or $tsaccounts.count -eq 0) 
    { 
        Write-Log "  $RDVHost is being added to the RDP-TCP permissions list" "verbose" 
         
        $permissionSettings = @(Get-WmiObject -Namespace $nameSpace -Query "SELECT * FROM Win32_TSPermissionsSetting WHERE TerminalName = 'RDP-TCP'") 
         
        foreach($setting in $permissionSettings) 
        { 
            $setting.addaccount("$RDVHost", 1) | Out-Null 
            ${script:restartRequired} = $TRUE 
        } 
    } 
 
    $tsAccounts = @(Get-WMIObject -Namespace $nameSpace -Query "SELECT * FROM Win32_TSAccount WHERE (TerminalName = 'RDP-TCP' OR TerminalName = 'Console') AND AccountName = '$($RDVHost.replace("\", "\\"))'") 
     
    foreach($account in $tsAccounts) 
    { 
        if (($account.PermissionsAllowed -band 517) -ne 517) 
        { 
            Write-Log "  Granting permissions : $RDVHost" "verbose" 
             
            $account.ModifyPermissions(0,1) | Out-Null 
            $account.ModifyPermissions(2,1) | Out-Null             
            $account.ModifyPermissions(9,1) | Out-Null 
             
            ${script:restartRequired} = $TRUE 
        } 
    } 
} 
 
 
function Configure-XP() 
{ 
    #   1. Enable Remote Desktop. 
 
    Write-Log "`n  Enabling Remote Desktop..." "verbose" 
 
    $result = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -ErrorAction SilentlyContinue 
 
    if ($result -eq $NULL) 
    { 
        $result = New-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -PropertyType DWORD -Value 0 
    } 
    elseif ($result.AllowRemoteRPC -ne 1) 
    { 
        $result = Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0 -Passthru 
        ${script:restartRequired} = $TRUE 
    } 
 
    if ($result.fDenyTSConnections -eq 0) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Remote Desktop could not be enabled" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   2. Enable RPC. 
 
    Write-Log "`n  Enabling RPC..." "verbose" 
     
    $result = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRpc -ErrorAction SilentlyContinue 
 
    if ($result -eq $NULL) 
    { 
        $result = New-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRPC -PropertyType DWORD -Value 1 
    } 
    elseif ($result.AllowRemoteRPC -ne 1) 
    { 
        $result = Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRpc -Value 1 -Passthru 
        ${script:restartRequired} = $TRUE 
    } 
     
    if ($result.AllowRemoteRpc -eq 1) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Remote Desktop could not be enabled" "error" 
        $anyFailures = $TRUE 
    } 
 
 
    #   3. Add users to the Remote Desktop Users group. 
 
    if (($RDUsers -ne $NULL) -AND ($RDUsers.Count -gt 0)) 
    { 
        Write-Log "`n  Adding users to Remote Desktop Users group..." "verbose" 
 
        $RDUsers | foreach {  
            net localgroup 'Remote Desktop Users' $_ /add 2> $Null > $Null 
            if ($LASTEXITCODE -eq 1) 
            { 
                Write-Log "      Failed to add user $_ to 'Remote Desktop Users' group..." "error" 
            } 
        } 
     
        Write-Log "    Done" "verbose" 
    } 
 
 
 
    #   4. Grant RD Virtualization Host servers permissions in the RDP-TCP listener. 
 
    Write-Log "`n  Granting RD Virtualization Host server RDP-TCP permissions..." "verbose" 
 
    $RDVHost | %{Grant-RDPPermissions $_ $TRUE} 
     
    Write-Log "    Done" "verbose" 
 
 
 
    #   5. Enable Windows Firewall to allow an exception for Remote Desktop. 
 
    Write-Log "`n  Enabling firewall for 'remote desktop'..." "verbose" 
 
    netsh firewall set service type=REMOTEDESKTOP mode=ENABLE profile=ALL 2> $Null > $Null 
    if ($LASTEXITCODE -eq 0) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Firewall could not be enabled for 'remote desktop'" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   6. Enable Windows Firewall to allow an exception for Remote Service Management. 
 
    Write-Log "  Enabling firewall for 'remote service management'..." "verbose" 
 
    netsh firewall set service remoteadmin enable subnet 2> $Null > $Null 
    if ($LASTEXITCODE -eq 0) 
    { 
        Write-Log "  Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Firewall could not be enabled for 'remote service management'" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   7. Restart the Remote Desktop Services service. 
 
    if ((-not $DoNotRestartService) -AND (${script:restartRequired})) 
    { 
        Write-Log "Rebooting machine..." "verbose" 
 
        shutdown /r /t 10 
    } 
} 
 
 
function Configure-PostXP() 
{ 
    #   1. Enable Remote Desktop. 
 
    Write-Log "`n  Enabling Remote Desktop..." "verbose" 
 
    $result = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -ErrorAction SilentlyContinue 
 
    if ($result -eq $NULL) 
    { 
        $result = New-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -PropertyType DWORD -Value 0 
    } 
    elseif ($result.AllowRemoteRPC -ne 1) 
    { 
        $result = Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0 -Passthru 
        ${script:restartRequired} = $TRUE 
    } 
 
    if ($result.fDenyTSConnections -eq 0) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Remote Desktop could not be enabled" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   2. Enable RPC. 
 
    Write-Log "`n  Enabling RPC..." "verbose" 
 
    $result = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRpc -ErrorAction SilentlyContinue 
 
    if ($result -eq $NULL) 
    { 
        $result = New-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRPC -PropertyType DWORD -Value 1 
    } 
    elseif ($result.AllowRemoteRPC -ne 1) 
    { 
        $result = Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name AllowRemoteRpc -Value 1 -Passthru 
        ${script:restartRequired} = $TRUE 
    } 
     
    if ($result.AllowRemoteRpc -eq 1) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Remote Desktop could not be enabled" "error" 
        $anyFailures = $TRUE 
    } 
 
 
    #   3. Add Users to the Remote Desktop Users group. 
 
    if (($RDUsers -ne $NULL) -AND ($RDUsers.Count -gt 0)) 
    { 
        Write-Log "`n  Adding users to the Remote Desktop Users group..." "verbose" 
 
        $RDUsers | foreach {  
            net localgroup 'Remote Desktop Users' $_ /add 2> $Null > $Null 
            if ($LASTEXITCODE -eq 1) 
            { 
                Write-Log "      Failed to add user $_ to the Remote Desktop Users group..." "error" 
            } 
        } 
     
        Write-Log "    Done" "verbose" 
    } 
 
 
 
    #   4. Grant RD Virtualization Host servers permissions in the RDP-TCP listener. 
 
    Write-Log "`n  Granting RD Virtualization hosts RDP-TCP listener permissions..." "verbose" 
 
    $RDVHost | %{Grant-RDPPermissions $_} 
 
    Write-Log "    Done" "verbose" 
 
 
 
    #   5. Enable Windows Firewall to allow an exception for Remote Desktop. 
 
    Write-Log "`n  Enabling firewall for 'remote desktop'..." "verbose" 
 
    netsh advfirewall firewall set rule group="remote desktop" new enable=yes 2> $Null > $Null 
    if ($LASTEXITCODE -eq 0) 
    { 
        Write-Log "    Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Firewall could not be enabled for 'remote desktop'" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   6. Enable Windows Firewall to allow an exception for Remote Service Management. 
 
    Write-Log "  Enabling firewall for 'remote service management'..." "verbose" 
 
    netsh advfirewall firewall set rule group="remote service management" new enable=yes 2> $Null > $Null 
    if ($LASTEXITCODE -eq 0) 
    { 
        Write-Log "  Done" "verbose" 
    } 
    else 
    { 
        Write-Log "Firewall could not be enabled for 'remote service management'" "error" 
        $anyFailures = $TRUE 
    } 
 
 
 
    #   7. Restart the Remote Desktop Services service. 
 
    if ((-not $DoNotRestartService) -AND (${script:restartRequired})) 
    { 
        Write-Log "Restarting the Remote Desktop Services service..." "verbose" 
 
        $termService = Get-Service "TermService" 
 
        Write-Log "  Stopping TermService..." "verbose" 
        $termService.Stop() 
        Start-Sleep 5 
 
        Write-Log "  Starting TermService..." "verbose" 
        $termService.Start() 
        Start-Sleep 5 
    } 
} 
 
function Test-ADObject ([string[]]$adEntries, [string[]]$Type) 
{ 
    $toExit = $FALSE 
    foreach($entry in $adEntries) 
    { 
        $adsiPath = "WinNT://{0}/{1}" -f ($entry -split "\\") 
        try  
        { 
            [ADSI]$adsiPath | Select-Object Name | Out-Null 
        } 
        catch 
        { 
            $throwError = !${script:Force} 
             
            if ($Type -contains "Computer") 
            { 
                $adsiPath = "WinNT://{0}/{1}$" -f ($entry -split "\\")                 
                try 
                { 
                    [ADSI]$adsiPath | Select-Object Name | Out-Null 
                    $throwError = $FALSE 
                } 
                catch { } 
            } 
             
            if ($throwError) 
            { 
                $toExit = $TRUE 
                Write-Log "Existence of specified object '$entry' could not be verified. $($_.Exception.InnerException.Message.Trim())" "error"                 
            } 
            continue 
        } 
         
        $adsiObj = [ADSI]$adsiPath 
         
        if ($adsiObj.Name -eq $NULL) 
        { 
            $toExit = $TRUE 
            Write-Log "Specified object '$entry' does not exist" "error" 
        } 
        elseif($Type -notcontains $adsiObj.Class) 
        { 
            $toExit = $TRUE 
            Write-Log "Specified object '$entry' is invalid. Specify an object of type $([string]::Join(" or ", $Type))" "error" 
        } 
    } 
     
    if ($toExit) 
    { 
        exit 1 
    } 
} 
 
Write-Log "" "initialize" 
Check-Credentials 
 
Write-Log "Preparing virtual machine for the RD Virtualization Host server: " "verbose" 
 
Write-Log "  RDV Host  : $([string]::Join(", ", $RDVHost))" "verbose" 
Test-ADObject $RDVHost @("Computer", "Group") 
 
if ($RDUsers.Count -gt 0) 
{ 
    Write-Log "  RD Users  : $([string]::Join(", ", $RDUsers))" "verbose" 
    Test-ADObject $RDUsers @("User", "Group") 
} 
 
$restartRequired = $FALSE 
$anyFailures = $FALSE 
 
$version = New-Object System.Version 6, 0, 0, 0 
if ([System.Environment]::OsVersion.Version -lt $version) 
{ 
    Configure-XP 
} 
else 
{ 
    Configure-PostXP 
} 
 
if ($anyFailures) 
{ 
    Write-Log "ERROR : There were one more errors preparing the virtual machine for the RD Virtualization Host server" "error" 
} 
else 
{ 
    Write-Log "Virtual machine was prepared for use with the RD Virtualization Host server" "verbose" 
    Write-Host "This virtual machine has been successfully configured for use with RD Virtualization." 
}