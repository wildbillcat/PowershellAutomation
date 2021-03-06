<#
.Synopsis
   This script should trigger a release from MSBuild
.DESCRIPTION
   This script should trigger a release from MSBuild. Corrected script to detect if the build has failed. Go Rest API! (Note this only works for VNext Templates)
.LINK
    http://blogs.msdn.com/b/visualstudioalm/archive/2014/10/10/trigger-release-from-build-with-release-management-for-visual-studio-2013-update-3.aspx
#>

param(
    [Parameter(Mandatory=$True)]
    [string]$rmserver,
    [Parameter(Mandatory=$True)]
    [string]$port, 
    [Parameter(Mandatory=$True)]
    [string]$teamProject,  
    [Parameter(Mandatory=$True)]
    [string]$targetStageName
    )
     
#First check to see if Build has Failed:
 
$BuildFailed = (Select-Xml -Path (get-childitem -Path "$Env:TF_BUILD_DROPLOCATION\logs" -Filter ActivityLog.AgentScope.*.xml)[0].FullName -XPath "//BuildInformationNode[@Type = 'BuildError']") -ne $null
 
 if($BuildFailed){
    "Build has failed! To not start a Release"
    exit 0
} 

#Continue
$teamFoundationServerUrl = $env:TF_BUILD_COLLECTIONURI
$buildDefinition = $env:TF_BUILD_BUILDDEFINITIONNAME
$buildNumber = $env:TF_BUILD_BUILDNUMBER

"Executing with the following parameters:`n"
"  RMserver Name: $rmserver"
"  Port number: $port"
"  Team Foundation Server URL: $teamFoundationServerUrl"
"  Team Project: $teamProject"
"  Build Definition: $buildDefinition"
"  Build Number: $buildNumber"
"  Target Stage Name: $targetStageName`n"

$exitCode = 0

trap
{
  $e = $error[0].Exception
  $e.Message
  $e.StackTrace
  if ($exitCode -eq 0) { $exitCode = 1 }
}

$scriptName = $MyInvocation.MyCommand.Name
$scriptPath = Split-Path -Parent (Get-Variable MyInvocation -Scope Script).Value.MyCommand.Path

Push-Location $scriptPath    

$server = [System.Uri]::EscapeDataString($teamFoundationServerUrl)
$project = [System.Uri]::EscapeDataString($teamProject)
$definition = [System.Uri]::EscapeDataString($buildDefinition)
$build = [System.Uri]::EscapeDataString($buildNumber)
$targetStage = [System.Uri]::EscapeDataString($targetStageName)

$serverName = $rmserver + ":" + $port
$orchestratorService = "http://$serverName/account/releaseManagementService/_apis/releaseManagement/OrchestratorService"

$status = @{
    "2" = "InProgress";
    "3" = "Released";
    "4" = "Stopped";
    "5" = "Rejected";
    "6" = "Abandoned";
}

$uri = "$orchestratorService/InitiateReleaseFromBuild?teamFoundationServerUrl=$server&teamProject=$project&buildDefinition=$definition&buildNumber=$build&targetStageName=$targetStage"
"Executing the following API call:`n`n$uri"

$wc = New-Object System.Net.WebClient
#$wc.UseDefaultCredentials = $true
# rmuser should be part rm users list and he should have permission to trigger the release.

$wc.Credentials = new-object System.Net.NetworkCredential("rmuser", "rmuserpassword", "rmuserdomain")

try
{
    $releaseId = $wc.DownloadString($uri)

    $url = "$orchestratorService/ReleaseStatus?releaseId=$releaseId"

    $releaseStatus = $wc.DownloadString($url)

    Write-Host -NoNewline "`nReleasing ..."

    while($status[$releaseStatus] -eq "InProgress")
    {
        Start-Sleep -s 5
        $releaseStatus = $wc.DownloadString($url)
        Write-Host -NoNewline "."
    }

    " done.`n`nRelease completed with {0} status." -f $status[$releaseStatus]
}
catch [System.Exception]
{
    if ($exitCode -eq 0) { $exitCode = 1 }
    Write-Host "`n$_`n" -ForegroundColor Red
}

if ($exitCode -eq 0)
{
  "`nThe script completed successfully.`n"
}
else
{
  $err = "Exiting with error: " + $exitCode + "`n"
  Write-Host $err -ForegroundColor Red
}

Pop-Location

exit $exitCode
