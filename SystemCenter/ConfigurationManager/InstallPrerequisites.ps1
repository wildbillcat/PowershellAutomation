<#  
.Synopsis  
    Prepares a computer for Chosen roles of System Center 2012 R2. 
    Really needs to be replaced with a DCS. 
     
.Description  
    This script configures the operating system on the virtual machine to support System Center Configuration Manager 2012R2.
    The prerequisites are based off of what was understood from http://technet.microsoft.com/en-us/library/gg682077.aspx#BKMK_SiteSysReqFunction and may not be complete.
    
    It installes the following rolls and features based off of the defined Configuration Manager Roles. 
            
        1. Site server : SITE
            Windows ADK
            .NET Framework 3.5:
                NET-Framework-Core
             .NET Framework 4.5
                NET-Framework-45-Core
             Remote Differential Compression
                RDC
        2. Database server: DATABASE
            SQL Server 2012 SP1
        3. SMS Provider Server: SMS
            Windows ADK
        4. Application Catalog web service point : WEBSERVICE
            .NET Framework 3.5:
                NET-Framework-Core
                NET-HTTP-Activation
            .NET Framework 4.5
                NET-Framework-45-Core
                NET-Framework-45-ASPNET
            IIS Configuration:
                Common HTTP Features:
                    Web-Default-Doc
                IIS 6 Management Compatibility:
                    Web-Metabase
                Application Development:
                     Web-Asp-Net
                     Web-Net-Ext
        5. Application Catalog website point : WEBSITE
            .NET Framework 3.5:
                NET-Framework-Core
            .NET Framework 4.5
                NET-Framework-45-Core
                NET-Framework-45-ASPNET
            IIS Configuration:
                Common HTTP Features:
                    Web-Default-Doc
                    Web-Static-Content                
                Application Development:
                    Web-Asp-Net
                    Web-Asp-Net45
                    Web-Net-Ext
                    Web-Net-Ext45
                Security:
                    Web-Windows-Auth
                IIS 6 Management Compatibility:
                    Web-Metabase
        6. Asset Intelligence synchronization point : ASSETINTELLIGENCE
            .NET Framework 4.5
                NET-Framework-45-Core
        7. Certificate registration point : CERTIFICATE
            .NET Framework 4.5
                NET-WCF-HTTP-Activation45
            IIS Configuration:             
                Application Development:
                    Web-Asp-Net
                    Web-Asp-Net45
                IIS 6 Management Compatibility:
                    Web-Metabase
                    Web-WMI
        8. Distribution point : DISTRIBUTION
            Windows Deployment Services (WDS) <- System Center will automatically install and configure when a PXE or Multicast Distribution point is configured 
            Remote Differential Compression
                RDC
            IIS Configuration:             
                Application Development:
                    Web-ISAPI-Ext
                Security:
                    Web-Windows-Auth
                IS 6 Management Compatibility:
                    Web-Metabase
                    Web-WMI
        9. Endpoint Protection point : ENDPOINTPROTECTION
            .NET Framework 3.5:
                NET-Framework-Core
        10.Enrollment point : ENROLLMENT
            .NET Framework 3.5:
                NET-Framework-Core
                NET-HTTP-Activation
            .NET Framework 4.5
                NET-Framework-45-Core
            IIS Configuration:
                Common HTTP Features:
                    Web-Default-Doc               
                Application Development:
                    Web-Asp-Net
                    Web-Net-Ext
                IIS 6 Management Compatibility:
                    Web-Metabase
        11.Enrollment proxy point : ENROLLMENTPROXY
            .NET Framework 3.5:
                NET-Framework-Core
            .NET Framework 4.5
                NET-Framework-45-Core
                NET-Framework-45-ASPNET
            IIS Configuration:
                Common HTTP Features:
                    Web-Default-Doc
                    Web-Static-Content                
                Application Development:
                    Web-Asp-Net
                    Web-Asp-Net45
                    Web-Net-Ext
                    Web-Net-Ext45
                Security:
                    Web-Windows-Auth
                IIS 6 Management Compatibility:
                    Web-Metabase
        12.Fallback status point : FALLBACK
            IIS 6 Management Compatibility:
                    Web-Metabase
        13.Management point : MANAGEMENT
            .NET Framework 4.5
                NET-Framework-45-Core
            BITS Server Extensions
                BITS-IIS-Ext
            IIS Configuration:             
                Application Development:
                    Web-ISAPI-Ext
                Security:
                    Web-Windows-Auth
                IS 6 Management Compatibility:
                    Web-Metabase
                    Web-WMI
        14.Out of band service point : OUTOFBAND
            .NET Framework 4.5
                NET-Framework-45-Core
        15.Reporting services point : REPORTING
            .NET Framework 4.5
                NET-Framework-45-Core
        16.Software update point : SOFTWAREUPDATE
            Requires the default IIS configuration
            .NET Framework 3.5:
                NET-Framework-Core
            .NET Framework 4.5
                NET-Framework-45-Core
        17.State migration point : STATEMIGRATION
            Requires the default IIS configuration
        18.System Health Validator point : HEALTHVALIDATOR
            This site system role is supported only on a NAP health policy server.
        19.Windows Intune connector : INTUNE
            .NET Framework 4.5
                NET-Framework-45-Core
    Note : Elevated permissions are required to execute this script. 
           
#>



param (  
    [Parameter(Mandatory=$TRUE, Position=0, HelpMessage="Enter Desired System Center Configuration Manager Roles Separated by Commas.
IE: SITE, WEBSERVICE, WEBSITE, SMS, DISTRIBUTION
Roles available:
1. Site server : SITE 
2. Database server: DATABASE
3. SMS Provider Server : SMS
4. Application Catalog web service point : WEBSERVICE
5. Application Catalog website point : WEBSITE
6. Asset Intelligence synchronization point : ASSETINTELLIGENCE
7. Certificate registration point : CERTIFICATE
8. Distribution point : DISTRIBUTION
9. Endpoint Protection point : ENDPOINTPROTECTION
10.Enrollment point : ENROLLMENT
11.Enrollment proxy point : ENROLLMENTPROXY
12.Fallback status point : FALLBACK
13.Management point : MANAGEMENT
14.Out of band service point : OUTOFBAND
15.Reporting services point : REPORTING
16.Software update point : SOFTWAREUPDATE
17.State migration point : STATEMIGRATION
18.System Health Validator point : HEALTHVALIDATOR
19.Windows Intune connector : INTUNE")] 
    [string[]] 
    $SCCMRoles, 
  
    [Parameter(Mandatory=$TRUE, Position=1, HelpMessage="Target Server that will have SCCM Roles Installed")] 
    [string] 
    $SCCMTargetServer
)

$ValidRoles = "SITE", "DATABASE", "SMS", "WEBSERVICE", "WEBSITE", "ASSETINTELLIGENCE", "CERTIFICATE", "DISTRIBUTION", "ENDPOINTPROTECTION", "ENROLLMENT", "ENROLLMENTPROXY", "FALLBACK", "MANAGEMENT", "OUTOFBAND", "REPORTING", "SOFTWAREUPDATE", "STATEMIGRATION", "HEALTHVALIDATOR", "INTUNE"

#Test to make sure only valid roles were requested
foreach($Role in $SCCMRoles){
    if(!($ValidRoles -contains $Role)){
        if(!("StandAloneServer" -eq $Role)){
            $Role + " is an invalid SCCM Role"
            return
        }
        #Test for Standard Config
        $SCCMRoles += "SITE"
        $SCCMRoles += "DATABASE"
        $SCCMRoles += "DISTRIBUTION"
        $SCCMRoles += "MANAGEMENT"
        $SCCMRoles += "STATEMIGRATION"
        $SCCMRoles += "ENROLLMENT"
        $SCCMRoles += "OUTOFBAND"
        $SCCMRoles += "REPORTING"
        $SCCMRoles += "WEBSERVICE"
        $SCCMRoles += "WEBSITE"
    }
    
}

#Test to Make Sure this Script is being run on Server 2012 R2, since it doesn't take in to consideration other OS requirements. If not 2012 R2 abort.
if(!(invoke-command -computername $SCCMTargetServer {(Get-WmiObject -class Win32_OperatingSystem).Caption.ToString().StartsWith("Microsoft Windows Server 2012 R2")})){
    "This Script should only be run on Microsoft Windows Server 2012 R2, and as not been designed for other operating systems. Aborting..."
    return
}

#This array will hold all of the system requirements for the System Center Server Rolls requested.
$SCCMPreRequisites = @()

#Test to see if any role requires .NET Framework 3.5
if(($SCCMRoles -contains "SITE") -or ($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "ENDPOINTPROTECTION") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY") -or ($SCCMRoles -contains "SOFTWAREUPDATE")){
    $SCCMPreRequisites += "NET-Framework-Core"
}

#Test to see if any role requires .NET Framework 3.5: HTTP Activation (and automatically selected options)
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "ENROLLMENT")){
    $SCCMPreRequisites += "NET-HTTP-Activation"
}

#Test to see if any role requires .NET Framework 4.5
if(($SCCMRoles -contains "SITE") -or ($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "ASSETINTELLIGENCE") -or ($SCCMRoles -contains "CERTIFICATE") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY") -or ($SCCMRoles -contains "MANAGEMENT") -or ($SCCMRoles -contains "OUTOFBAND") -or ($SCCMRoles -contains "REPORTING") -or ($SCCMRoles -contains "SOFTWAREUPDATE") -or ($SCCMRoles -contains "INTUNE")){
    $SCCMPreRequisites += "NET-Framework-45-Core"
}

#Test to see if any role requires .NET Framework 4.5: HTTP Activation
if(($SCCMRoles -contains "CERTIFICATE")){
    $SCCMPreRequisites += "NET-HTTP-Activation"
}

#Test to see if any role requires .NET Framework 4.5: ASP.NET 4.5
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "NET-Framework-45-ASPNET"
}

#Test to see if any role requires Remote Differential Compression
if(($SCCMRoles -contains "SITE") -or ($SCCMRoles -contains "DISTRIBUTION")){
    $SCCMPreRequisites += "RDC"
}

#Test to see if any role requires the default IIS configuration
if(($SCCMRoles -contains "FALLBACK") -or ($SCCMRoles -contains "SOFTWAREUPDATE") -or ($SCCMRoles -contains "STATEMIGRATION")){
    $SCCMPreRequisites += "Web-Server"
}

#Test to see if any role requires Common HTTP Features: Default Document
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Default-Doc"
}

#Test to see if any role requires Common HTTP Features: Static Content
if(($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Static-Content"
}

#Test to see if any role requires Application Development: ASP.NET 3.5 (and automatically selected options)
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "CERTIFICATE") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Asp-Net"
}

#Test to see if any role requires Application Development: .NET Extensibility 3.5
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Net-Ext"
}

#Test to see if any role requires Application Development: ASP.NET 4.5 (and automatically selected options)
if(($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "CERTIFICATE") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Asp-Net45"
}

#Test to see if any role requires Application Development: .NET Extensibility 4.5
if(($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "ENROLLMENTPROXY")){
    $SCCMPreRequisites += "Web-Net-Ext45"
}

#Test to see if any role requires Application Development: ISAPI Extensions
if(($SCCMRoles -contains "DISTRIBUTION") -or ($SCCMRoles -contains "MANAGEMENT")){
    $SCCMPreRequisites += "Web-ISAPI-Ext"
}

#Test to see if any role requires Security: Windows Authentication
if(($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "DISTRIBUTION") -or ($SCCMRoles -contains "ENROLLMENTPROXY") -or ($SCCMRoles -contains "MANAGEMENT")){
    $SCCMPreRequisites += "Web-Windows-Auth"
}

#Test to see if any role requires IIS 6 Management Compatibility: IIS 6 Metabase Compatibility
if(($SCCMRoles -contains "WEBSERVICE") -or ($SCCMRoles -contains "WEBSITE") -or ($SCCMRoles -contains "DISTRIBUTION") -or ($SCCMRoles -contains "ENROLLMENT") -or ($SCCMRoles -contains "ENROLLMENTPROXY") -or ($SCCMRoles -contains "FALLBACK") -or ($SCCMRoles -contains "MANAGEMENT")){
    $SCCMPreRequisites += "Web-Metabase"
}

#Test to see if any role requires IIS 6 Management Compatibility: IIS 6 WMI Compatibility
if(($SCCMRoles -contains "CERTIFICATE") -or ($SCCMRoles -contains "DISTRIBUTION") -or ($SCCMRoles -contains "MANAGEMENT")){
    $SCCMPreRequisites += "Web-WMI"
}

#Test to see if any role requires BITS Server Extensions
if(($SCCMRoles -contains "MANAGEMENT")){
    $SCCMPreRequisites += "BITS-IIS-Ext"
}

#Now that the SCCM PreRequisites Have Been determined, lets warn the user about any prerequisites that have to be set up outsite of this script
get-date >> ($PSScriptRoot + "\installLog.txt")

"Desired Roles: "  >> ($PSScriptRoot + "\installLog.txt")
$SCCMRoles  >> ($PSScriptRoot + "\installLog.txt")

"Script Determined prerequisites:"  >> ($PSScriptRoot + "\installLog.txt")
$SCCMPreRequisites  >> ($PSScriptRoot + "\installLog.txt")

#Both the SITE and SMS Roles require the Windows 8.1 ADK. 
if(($SCCMRoles -contains "SITE") -or ($SCCMRoles -contains "SMS")){
    "Both the SITE and SMS Roles require the Windows 8.1 ADK. Be Sure to install it for your configuration."
    "Both the SITE and SMS Roles require the Windows 8.1 ADK. Be Sure to install it for your configuration." >> ($PSScriptRoot + "\installLog.txt")
    $Answer = Read-Host "Enter to Continue"
}

#The DATABASE Role requires the SQL Server. 
if(($SCCMRoles -contains "DATABASE")){
    "The DATABASE Role requires the SQL Server. Be Sure to install it for your configuration."
    $Answer = Read-Host "Enter to Continue"
}

#The DISTRIBUTION Role has an optional requirement of WDS. System Center 2012 R2 automatically installs and configures this role if PXE or multicast is enabled.
if(($SCCMRoles -contains "DISTRIBUTION")){
    "The DISTRIBUTION Role has an optional requirement of WDS. System Center 2012 R2 automatically installs and configures this role if PXE or multicast is enabled."
    "The DISTRIBUTION Role has an optional requirement of WDS. System Center 2012 R2 automatically installs and configures this role if PXE or multicast is enabled." >> ($PSScriptRoot + "\installLog.txt")
    $Answer = Read-Host "Enter to Continue"
}

#The SOFTWAREUPDATE Role requires the WSUS Role be installed.
if(($SCCMRoles -contains "SOFTWAREUPDATE")){
    "The SOFTWAREUPDATE Role requires the WSUS Role be installed. Be Sure to install it for your configuration."
    "The SOFTWAREUPDATE Role requires the WSUS Role be installed. Be Sure to install it for your configuration." >> ($PSScriptRoot + "\installLog.txt")
    $Answer = Read-Host "Enter to Continue"
}

#The REPORTING Role requires Microsoft SQL Server Reporting Services be installed and configured.
if(($SCCMRoles -contains "REPORTING")){
    "The REPORTING Role requires Microsoft SQL Server Reporting Services be installed and configured. Be Sure to install it for your configuration."
    "The REPORTING Role requires Microsoft SQL Server Reporting Services be installed and configured. Be Sure to install it for your configuration." >> ($PSScriptRoot + "\installLog.txt")
    $Answer = Read-Host "Enter to Continue"
}

"The Following Command is about to be run:"
"Install-WindowsFeature –Name " + ($SCCMPreRequisites -join ", ")

#while true doesn't appear to work, so heres the equivlent.
while((1 -eq 1)){ 
    "Would you like to include Management Tools?"
    $Answer = Read-Host "Yes/No/Abort"
    if($Answer -contains "yes"){
          "Initializing install with Managment Tools"
          "Initializing install with Managment Tools"  >> ($PSScriptRoot + "\installLog.txt")
          Install-WindowsFeature –Name $SCCMPreRequisites -ComputerName $SCCMTargetServer -IncludeManagementTools
          break
    }
    if($Answer -contains "no"){
          "Initializing install without Managment Tools"
          "Initializing install without Managment Tools"  >> ($PSScriptRoot + "\installLog.txt")
          Install-WindowsFeature –Name $SCCMPreRequisites -ComputerName $SCCMTargetServer
          break
    }
    if($Answer -contains "abort"){
          "Aborting installation Script"
          "Aborting installation Script" >> ($PSScriptRoot + "\installLog.txt")
          break
    }
    "Invalid Input, Try again"
}
"Script Complete"
"Script Complete"  >> ($PSScriptRoot + "\installLog.txt")