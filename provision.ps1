# Define variables
## Elastic Agent / Fleet
Set-Variable -Name "elastic-version" -Value "7.15.0" 
Set-Variable -Name "elastic-fleet-url" -Value "your-elastic-fleet-url"
Set-Variable -Name "elastic-fleet-policy-enrollment-token" -Value "your-elastic-fleet-policy-enrollment-token"
$ProgressPreference = 'SilentlyContinue'

## Elastic Cloud (Winlogbeat / Packetbeat)
Set-Variable -Name "elastic-username" -Value "your-elastic-stack-username (default is elastic)"
Set-Variable -Name "elastic-passphrase" -Value "your-elastic-passphrase"
Set-Variable -Name "elastic-cloud-id" -Value "your-elastic-cloud-id"

## OpenVPN Authentication
Set-Variable -Name "openvpn-username" -Value "your-openvpn-username"
Set-Variable -Name "openvpn-passphrase" -Value "your-openvpn-passphrase"

# Install Chocolatey
choco upgrade all -y
refreshenv

# Packetbeat
## libpcap prerequisite 
Invoke-WebRequest -Uri "https://nmap.org/npcap/dist/npcap-0.86.exe" -OutFile "c:\users\vagrant\Desktop\npcap.exe"
c:\users\vagrant\desktop\npcap.exe /S /winpcap_mode=yes

## Install Packetbeat
choco install packetbeat -y
(Get-Content c:\users\vagrant\desktop\packetbeat.yml).replace('elastic-username', ${elastic-username}) | Set-Content C:\users\vagrant\Desktop\packetbeat.yml
(Get-Content c:\users\vagrant\desktop\packetbeat.yml).replace('elastic-passphrase', ${elastic-passphrase}) | Set-Content C:\users\vagrant\Desktop\packetbeat.yml
(Get-Content c:\users\vagrant\desktop\packetbeat.yml).replace('elastic-cloud-id', ${elastic-cloud-id}) | Set-Content C:\users\vagrant\Desktop\packetbeat.yml
Move-Item -force c:\users\vagrant\desktop\packetbeat.yml c:\programdata\chocolatey\lib\packetbeat\tools\
start-service packetbeat

# Winlogbeat
choco install winlogbeat -y
(Get-Content c:\users\vagrant\desktop\winlogbeat.yml).replace('elastic-username', ${elastic-username}) | Set-Content C:\users\vagrant\Desktop\winlogbeat.yml
(Get-Content c:\users\vagrant\desktop\winlogbeat.yml).replace('elastic-passphrase', ${elastic-passphrase}) | Set-Content C:\users\vagrant\Desktop\winlogbeat.yml
(Get-Content c:\users\vagrant\desktop\winlogbeat.yml).replace('elastic-cloud-id', ${elastic-cloud-id}) | Set-Content C:\users\vagrant\Desktop\winlogbeat.yml
Move-Item -force c:\users\vagrant\desktop\winlogbeat.yml c:\programdata\chocolatey\lib\winlogbeat\tools\
start-service winlogbeat

# Elastic Agent
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-${elastic-version}-windows-x86_64.zip -OutFile "c:\users\vagrant\Desktop\elastic-agent.zip"
Expand-Archive -F c:\users\vagrant\desktop\elastic-agent.zip -DestinationPath c:\users\vagrant\desktop\elastic-agent
& c:\users\vagrant\Desktop\elastic-agent\elastic-agent-${elastic-version}-windows-x86_64\elastic-agent.exe install -f --url=${elastic-fleet-url} --enrollment-token=${elastic-fleet-policy-enrollment-token}

# OpenVPN
choco install openvpn -y
(Get-Content "c:\users\vagrant\desktop\openvpn-auth.conf").replace('openvpn-username', ${openvpn-username}) | Set-Content "c:\users\vagrant\desktop\openvpn-auth.conf"
(Get-Content "c:\users\vagrant\desktop\openvpn-auth.conf").replace('openvpn-passphrase', ${openvpn-passphrase}) | Set-Content "c:\users\vagrant\desktop\openvpn-auth.conf"
Move-item -force "c:\users\vagrant\desktop\openvpn-auth.conf" "c:\\program files\\OpenVPN\\config\\openvpn-auth.conf"

# WireShark
choco install wireshark -y

# Adobe Reader
choco install adobereader -y

# Microsoft Outlook
choco install office365business --params="/productid:O365HomePremRetail" /exclude:"Access Groove Lync OneDrive OneNote Publisher" /eula:"TRUE" -y

# Network Miner
Invoke-WebRequest -Uri "https://www.netresec.com/?download=NetworkMiner" -OutFile "c:\users\vagrant\desktop\networkminer.zip"
Expand-Archive -F c:\users\vagrant\desktop\networkminer.zip -DestinationPath c:\users\vagrant\desktop\networkminer

# ApateDNS
Invoke-WebRequest -Uri "https://www.fireeye.com/content/dam/fireeye-www/services/freeware/sdl-apatedns.zip" -OutFile "c:\users\vagrant\desktop\apatedns.zip"
Expand-Archive -F c:\users\vagrant\desktop\apatedns.zip -DestinationPath c:\users\vagrant\desktop\apatedns

# Sysmon
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile "c:\users\vagrant\Desktop\Sysmon.zip"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile "c:\users\vagrant\Desktop\sysmonconfig-export.xml"
Expand-Archive -F c:\users\vagrant\desktop\Sysmon.zip -DestinationPath c:\users\vagrant\desktop\sysmon
c:\users\vagrant\desktop\sysmon\sysmon64.exe -accepteula -i c:\users\vagrant\desktop\sysmonconfig-export.xml

# SysInternals tools
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/SysinternalsSuite.zip" -OutFile "c:\users\vagrant\Desktop\sysinternals.zip"
Expand-Archive -F c:\users\vagrant\desktop\sysinternals.zip -DestinationPath c:\users\vagrant\desktop\sysinternals

# Process Hacker
Invoke-WebRequest -Uri "https://github.com/processhacker/processhacker/releases/download/v2.39/processhacker-2.39-setup.exe" -OutFile "c:\users\vagrant\Desktop\processhacker.exe"

# Advanced logging
Invoke-WebRequest -Uri "https://www.malwarearchaeology.com/s/Set_Adv_Auditing_Folders_Keys_vDec_2018-fa6n.zip" -OutFile "c:\users\vagrant\Desktop\audit.zip"
Expand-Archive -F "c:\users\vagrant\Desktop\audit.zip" -DestinationPath "c:\users\vagrant\desktop\audit"
c:\users\vagrant\desktop\audit\1_Set_Audit_Pol_PS_v2_3_4_5.cmd
c:\users\vagrant\desktop\audit\2_Set_User_Folder_Auditing_v2.cmd
c:\users\vagrant\desktop\audit\3_Set_User_Registry_Auditing.cmd
c:\users\vagrant\desktop\audit\Set_User_Registry_Auditing.ps1

# Cleanup
Clear-Variable elastic* -Scope Global 
Remove-Item -recurse -Force c:\users\vagrant\desktop\elastic*, c:\users\vagrant\desktop\*.zip, c:\users\vagrant\desktop\sysmon*, c:\users\vagrant\desktop\audit*, c:\users\vagrant\desktop\provision.ps1, c:\users\vagrant\desktop\*.exe, c:\tmp\vagrant-shell.ps1
