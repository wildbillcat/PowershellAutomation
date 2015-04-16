#REQUIRES -Version 4.0
<#
.Synopsis
   Quick Summary of script
.DESCRIPTION
   Detailed description of all the various things the script may do.
.EXAMPLE
   Template.ps1 -MachineName PC1,PC2,PC3 
.LINK
    mailto:kingrolloinc@sbcglobal.net
.DEVEL
    Any notes on the developemnt of the script, if nessisary
#>

param(
   $MachineName
   )

Configuration DSCConfiguration
{
    param(
    $MachineName
    )
   
   $UserName = "test" #This is the username stored in the GPO for Signage Machines
   $Password = "!MY573RyP@55w0rd" | ConvertTo-SecureString -asPlainText -Force #This is the password stored int he GPO for Signage Machines
   $ResourceShare = "\\arch-cfgmgr\PowershellDCSResources\Signage"

   Node $MachineName 
   {
      User AddUser #Adds the User with a Cleartext password
      {
        UserName = $UserName
        Password = New-Object System.Management.Automation.PSCredential ($UserName, $Password)
        Ensure = "Present"
        PasswordChangeNotAllowed = $true
        PasswordChangeRequired = $false
        PasswordNeverExpires = $true
      }
      #Example package that installs flash
      Package AdobeFlash
      {
        Ensure = "Present"  # You can also set Ensure to "Absent"
        Path  = "$ResourceShare\install_flash_player_14_active_x.msi"
        Name = "Adobe Flash Player 14 ActiveX"
        ProductId = "15AE611F-5A40-4BD0-9291-1C6856BDB9A4"
        DependsOn = "[User]AddSignageUser"
      }
      
        #This runs a GPUpdate to pull down the latest Group Policy configuration
      Script GPUpdateComputer
        {
        SetScript = {         
        gpupdate /force
        }
        TestScript = { $false }
        GetScript = { <# This must return a hash table #> }          
     }
   }
}

#Move-ADObject -Identity (Get-ADComputer $MachineName).objectguid -TargetPath "OU=Signage,OU=Infrastructure,OU=Architecture,OU=Architecture,DC=yu,DC=yale,DC=edu"

$ConfigurationData = @{  
    AllNodes = @(        
        @{    
            NodeName = $MachineName;                            
            PSDscAllowPlainTextPassword = $true;
         }
    )  
}

DSCConfiguration -MachineName $MachineName -configurationData $ConfigurationData #This allows the script to be run and generate the MOF files.
