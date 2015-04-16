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
#    [string]$RMBackupPath   #This path is set as a server level configuration variable that defines where release managment stores deployment backups. 
#)

$localBackupDir = "$env:TEMP\$ReleaseId\$BuildDefinition"
$remoteBackupDir = "$RMBackupPath\$ReleaseId\$BuildDefinition"

#Parse parameters and prepare to run script. Validate Values
$localdeploymentBackupPath = "$localBackupDir\$Stage" 
$remotedeploymentBackupPath = "$remoteBackupDir\$Stage\$env:COMPUTERNAME" 

Add-PSSnapin WDeploySnapin3.0

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
$IISApplicationPackage = $oXMLDocument.Applications.$IISApplicationName.Value


#Rollback the Currently Installed Site
$RollbackResults = Restore-WDPackage "$remotedeploymentBackupPath\$IISApplicationPackage"

$RollbackResults
