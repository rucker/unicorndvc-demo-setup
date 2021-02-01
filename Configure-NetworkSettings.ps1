Write-Host 'Set host-only adapter network to Private...'
Set-NetConnectionProfile -InterfaceAlias 'Ethernet 2' -NetworkCategory Private

Write-Host 'Enable Remote Desktop connections...'
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name 'fDenyTSConnections' -value 0

Write-Host 'Update Firewall Rules...'
Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'
Enable-NetFirewallRule -DisplayGroup 'File and Printer Sharing'
