<#
.Synopsis
   This script backs up a Web Application so that it can be redeployed as a part of a rollback
.DESCRIPTION
   This script should be run prior to a web deploy, that way the backs up of the Web Application
   can be web deployed back onto the server should the new package deployment fail.
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>
#Defining the params (where easier for a human to read) appears to cause the local instances to overwrite the RM evironment
#Param(
#    [Parameter(Mandatory=$false)]
#    [string]$IISApplicationName,#This is the name of the IIS application to be backed up.

#	[Parameter(Mandatory=$false)] 
#    [string]$ReleaseId,			#This is a System Variable for Release Managment. It is the unique ID of the Release.
	
#	[Parameter(Mandatory=$false)] 
#    [string]$Stage,				#This is a System Variable for Release Managment. It denotes what stage in the
#								#Deployment
#	[Parameter(Mandatory=$false)] 
#    [string]$BuildDefinition,	#This is a System Variable for Release Managment. This is the name of the component build definition
#								#being deployed. This is important if a release template deploys multiple web deploy components 
#								#(packages) to the same server 
#	[Parameter(Mandatory=$false)] 
#    [string]$RMBackupPath		#This path is set as a server level configuration variable that defines where release managment stores deployment backups. 
#)


#Parse parameters and prepare to run script. Validate Values
$localdeploymentBackupPath = "$env:TEMP\$ReleaseId\$Stage\$BuildDefinition" 
$remotedeploymentBackupPath = "$RMBackupPath\$ReleaseId\$Stage\$BuildDefinition\$env:COMPUTERNAME" 

Add-PSSnapin WDeploySnapin3.0

#Back up the Currently Installed Site
$BackupResults = Backup-WDApp $IISApplicationName
$BackupPackage = Get-Item (($BackupResults).Package)
$BackupPackage
$BackupPackageName = $BackupPackage.Name

#Create the backup directory to store the Package File
If(!(Test-Path $localdeploymentBackupPath)){
    New-Item $localdeploymentBackupPath -type directory
}

#Create the backup directory to store the Package File
If(!(Test-Path $remotedeploymentBackupPath)){
    New-Item $remotedeploymentBackupPath -type directory
}

$ApplicationXMLPath = "$remotedeploymentBackupPath\Applications.xml"
#Test for the XML File which tracks the backup pkg files to their Application paths.
If(!(Test-Path "$ApplicationXMLPath")){
    [System.XML.XMLDocument]$oXMLDocument=New-Object System.XML.XMLDocument
	# New Node
	[System.XML.XMLElement]$oXMLRoot=$oXMLDocument.CreateElement("Applications")
	# Append as child to an existing node
	$oXMLDocument.appendChild($oXMLRoot)
	# Add a Attribute
	$oXMLRoot.SetAttribute("description","This Contains a list of Application Paths on the server and the back up package for it")
	#[System.XML.XMLElement]$oXMLSystem=$oXMLRoot.appendChild($oXMLDocument.CreateElement("system"))
	$oXMLDocument.Save("$ApplicationXMLPath")
}

If(!(Test-Path "$ApplicationXMLPath")){
    "XML Failed to Propigate!"
    exit 5
}
#Open XML File
[xml]$oXMLDocument=Get-Content -Path "$ApplicationXMLPath"
#Get Application List
$oXMLRoot = $oXMLDocument.Applications
#Add Application
[System.XML.XMLElement]$oXMLApplication = $oXMLRoot.appendChild($oXMLDocument.CreateElement("Application"))
#Add Application Path
$oXMLApplication.SetAttribute("Name", "$IISApplicationName")
$oXMLApplication.SetAttribute("Package", "$BackupPackageName")
Set-Content -Value $oXMLDocument -Path $ApplicationXMLPath

Copy-Item -Force -Path $BackupPackage -Destination "$localdeploymentBackupPath\$BackupPackageName"

#Ensure Local Backup was taken
If(!(Test-Path "$localdeploymentBackupPath\$BackupPackageName")){
    "Warning! The local backup was not generated!"
    exit 1
}

Copy-Item -Force -Path $BackupPackage -Destination "$remotedeploymentBackupPath\$BackupPackageName"

#Ensure Remote Backup was taken
If(!(Test-Path "$remotedeploymentBackupPath\$BackupPackageName")){
    throw "Warning! The remote backup was not generated!"
    exit 2
}
return $true