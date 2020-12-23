Begin {
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You are not running this as local administrator. Run it again in an elevated prompt." ; break
    }

    $choco = get-command -Name choco.exe -ErrorAction SilentlyContinue
    if ($choco -eq $Null) {
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    choco install -y poshgit dotnetcore-3.1-sdk

    Add-WindowsCapability -Online -Name NetFx3~~~~

    $proc = Start-Process PowerShell -ArgumentList .\Setup-UnicornTestApp.ps1
    $handle = $proc.Handle
    $proc.WaitForExit()
    if ($proc.ExitCode -ne 0) {
        Write-Warning "It looks like Setup-UnicornTestApp.ps1 did not complete successfully."
        Write-Warning "Please try running the script again and note any errors shown."
    }
}
