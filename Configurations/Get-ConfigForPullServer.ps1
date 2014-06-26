<#
.Synopsis
   This is a renaming script
.DESCRIPTION
   This is a script that renames MOF files from their computers names to instead their AD GUIDs.
   This also generates the checksums of the files, so the output can be copied directly onto the DSC Server.
   The Brilliance of this script is originally based off of:
   http://blog.cosmoskey.com/powershell/desired-state-configuration-in-pull-mode-over-smb
.EXAMPLE
   Get-ConfigForPullServer.ps1 -inputConfigPath c:\signageConfig\ -outputConfigPath \\DCSPullserver.myserver.com\DSCshare$
.LINK
    mailto:patrick.mcmorran@yale.edu
#>

Param(
    [Parameter(Mandatory=$true)]
    [string]$inputConfigPath,
    [Parameter(Mandatory=$true)]
    [string]$outPutConfigPath
    )

Function Get-ComputerGuid {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName
    )
    process {
        ([guid]([adsisearcher]"(samaccountname=$ComputerName`$)").FindOne().Properties["objectguid"][0]).Guid
    }
}

Get-ChildItem $inputConfigPath -Filter *.mof |
Foreach-Object{
    $newFilePath = "$outPutConfigPath\$(Get-ComputerGuid $_.BaseName).mof"
    $newMof = copy $_.FullName $newFilePath -PassThru -Force
    $newHash = (Get-FileHash $newMof).hash
    [System.IO.File]::WriteAllText("$newMof.checksum",$newHash)    
}



