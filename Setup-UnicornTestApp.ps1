if (-not (Test-Path ~/repos)) {
    mkdir ~/repos | Out-Null
}
cd ~/repos
if (-not (Test-Path unicorndvctestapp)) {
    # If git was just installed in the parent shell, it won't be found on $PATH yet
    & 'C:\Program Files\Git\cmd\git.exe' clone https://github.com/BabbageCom/unicorndvctestapp.git
}

$setupFile = "$env:TEMP\unicorndvc_3.1.1.exe"
if (-not (Test-Path $setupFile)) {
    Write-Host "Downloading UnicornDVC installer..."
    Invoke-WebRequest https://download.babbage.com/access4u/unicorndvc_3.1.1.exe -UseBasicParsing -OutFile $setupFile
}

Write-Host "Running UnicornDVC installer..."
$proc = Start-Process $setupFile -PassThru -Wait
$handle = $proc.Handle
$proc.WaitForExit()

if ($proc.ExitCode -ne 0) {
    Write-Warning "It looks like UnicornDVC Setup failed or was cancleled."
    Write-Warning "Please check the file $setupFile and run again"
    Read-Host -Prompt "Press Enter to exit"
}
else {
    Write-Host "UnicornDVC test app setup complete. Code can be found in ~/repos/unicorndvctestapp"
    Read-Host -Prompt "Press Enter to continue"
}
