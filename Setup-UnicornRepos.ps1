mkdir ~/repos
cd ~/repos
git clone https://github.com/BabbageCom/unicorndvctestapp.git
cd unicorndvctestapp
Invoke-WebRequest https://download.babbage.com/access4u/unicorndvc_3.1.1.exe -UseBasicParsing -OutFile $env:TEMP/unicorndvc_3.1.1.exe
Start-Process $env:TEMP\unicorndvc_3.1.1.exe -Wait

Write-Host "Unicorn repos setup complete."
Read-Host -Prompt "Press Enter to continue"
