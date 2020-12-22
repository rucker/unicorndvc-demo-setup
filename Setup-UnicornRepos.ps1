if (-not (Test-Path ~/repos)) {
    mkdir ~/repos
}
cd ~/repos
if (-not (Test-Path unicorndvctestapp)) {
	# If git was just installed in the parent shell, it won't be found on $PATH yet
	& 'C:\Program Files\Git\cmd\git.exe' clone https://github.com/BabbageCom/unicorndvctestapp.git
}
cd unicorndvctestapp
Invoke-WebRequest https://download.babbage.com/access4u/unicorndvc_3.1.1.exe -UseBasicParsing -OutFile $env:TEMP/unicorndvc_3.1.1.exe
Start-Process $env:TEMP\unicorndvc_3.1.1.exe -Wait

Write-Host "Unicorn repos setup complete."
Read-Host -Prompt "Press Enter to continue"
