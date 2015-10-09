<#
.Synopsis
   This script can be used to return MSI properties for automation.
.DESCRIPTION
   This script takes the path to an MSI file and returns the properties of the MSI File.
.EXAMPLE
   Get-MSIVariable.ps1 -Path "C:\IIS\installer.msi" 
.LINK
    mailto:kingrolloinc@sbcglobal.net
#>
Param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

$Installer = New-Object -ComObject WindowsInstaller.Installer

$Database = $Installer.GetType().InvokeMember(
            "OpenDatabase", "InvokeMethod", $Null, 
            $Installer, @($Path, 0)
        )

$View = $Database.GetType().InvokeMember(
            "OpenView", "InvokeMethod", $Null, $Database, ("Select * From Property")
        )

$View.GetType().InvokeMember("Execute", "InvokeMethod", $Null, $View, $Null)

"Property Rows Found:"
""
while($true){
    $Record = $null
    $Record = $View.GetType().InvokeMember(
            "Fetch", "InvokeMethod", $Null, $View, $Null
        )
    if($Record -eq $null){
        break
    }
    $ColumnCount = $Record.FieldCount()
    $Row = $Record.StringData(0)
    for($i = 1; $i -le $ColumnCount; $i++){
        $Row += " : " + $Record.StringData($i)
    }
    $Row
}