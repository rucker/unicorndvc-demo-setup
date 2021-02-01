# unicorndvc-demo-setup
This repo contains two scripts:
- A bash script to create two VirtualBox VMs
- PowerShell scripts to set up the [UnicornDVC test app](https://github.com/BabbageCom/unicorndvctestapp/) and install dependencies

## Prerequisites
- [VirtualBox](https://virtualbox.org/wiki/Downloads)
- [Microsoft Edge Windows 10 VM image](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/)

## Notes
* (MacOS High Sierra or later) If you encounter the following error, the two steps below should resolve the issue:
```
VBoxManage: error: VBoxNetAdpCtl: Error while adding new interface: failed to open /dev/vboxnetctl: No such file or directory
```

  1. Grant VirtualBox permission under System Preferences > Privacy & Security > General
  2. run `sudo launchctl load /Library/LaunchDaemons/org.virtualbox.startup.plist` ([source](https://stackoverflow.com/a/36999421))
- On first login, Windows launches ".NET Runtime Optimization Service" which will tie up the CPU for the first few minutes
- If you see the following dialog after completing setup when running `ConsoleApp2.exe`, it should not be necessary to install the feature. Instead hit Cancel, reboot the machine and try again
![Install .NET Framework 3.5](images/need-framework-35.png)

## Creating the VMs
To set up virtual machines, run `virtualbox-setup` and pass to it one or more machine names to be created. The script will:
- Create/configure VMs
- Create a host-only network and configure the VMs to use it via a second NIC so they can talk to each other
- Mount a shared drive (`Z:`) containing this repo (which allows running the PowerShell scripts inside the machine)
- Mount the [Guest Additions](https://docs.oracle.com/cd/E36500_01/E36502/html/qs-guest-additions.html) .iso in the machine DVD drive for easy installation

NOTE: It is assumed that the VM image and its related .ovf file are located in `~/Downloads/MSEdge - Win10/`. If you extracted these files to another location, you can specify it by modifying the script.  

In addition, you can change the machine parameters (RAM, VRAM, CPU, etc) by modifying the relevant parameters in the script.  

## Setting up the VMs
Once the machines are created: start them, run PowerShell as Administrator, and run `Install-Requirements.ps1` (which should be found on `Z:`). This script will:
- Install prerequisites including git, .NET Framework 3.5 (required by UnicornDVC libraries) and dotnet core 3.1 (required by the demo app)
- Run `Setup-UnicornTestApp.ps1` which will clone the demo app repo and launch the UnicornDVC installer.

Next, run `Configure-NetworkSettings.ps1`. This script will:
- Set the host-only network type to Private
- Enable Remote Desktop connections
- Update Windows Firewall rules to allow Remote Desktop and File Sharing
