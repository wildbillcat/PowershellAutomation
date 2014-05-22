$webclient = New-Object System.Net.WebClient
$url = "http://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc/file/41459/43/PSWindowsUpdate.zip"
$file = "C:\Windows\Temp\PSWindowsUpdate.zip"
$Powershelldestination = “C:\Windows\System32\WindowsPowerShell\v1.0\Modules”
$webclient.DownloadFile($url.ToString(), $file.ToString())


$shell_app = new-object -com shell.application
$zip_file = $shell_app.namespace($file.ToString())
$destination = $shell_app.namespace($Powershelldestination.ToString())
$destination.Copyhere($zip_file.items())
