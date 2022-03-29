# Windows 11 Sandbox to Elastic Cloud

This project is aimed at rapidly building a Windows 11 system to use for dynamic malware analysis (sandbox), sending data to Elastic Cloud.

There is always improvements to be had, this may not work for malware with defensive capabilties, but this should get you going. 

Once you spin this up, you'll have:

* Windows 11
* Elastic Agent
* Sysmon w/SOS config
* OpenVPN
* Microsoft Office (Word, PowerPoint, Excel, Outlook, etc.)
* Adobe Reader
* Wireshark
* Collection/anlaysis on the Desktop (not installed)
  * ApateDNS
  * NetworkMiner
  * SysInternals
  * Process Hacker

Everything will be reporting into Elastic Cloud.

## Getting Started

This is pretty straight forward, but you'll need to do a bit of preparation work.

### Requirements

- Vagrant ([download](https://www.vagrantup.com/downloads))
- VirtualBox ([download](https://www.virtualbox.org/wiki/Downloads))
- Elastic Stack (by default, this will leverage [Elastic Cloud](https://cloud.elastic.co), but you can make modifications to fit your environment)
  - Your Elastic username
  - Your Elastic passphrase
  - Your Elastic Cloud ID
  - Your Fleet URL
  - Your Fleet enrollment token for the policy you're going to use
  - (Optional) Your OpenVPN configuration and authentication credentials

If you want to try a local Elastic Stack, you can use this [dev (read, **NOT FOR PRODUCTION**) project](https://github.com/peasead/elastic-container). The dev project will require some tuning as it runs in Docker, not Elastic Cloud. Create an Issue and I can probably help with some config updates.

### Preparation

Before you run this, you'll need to update the variables in [provision.ps1](provision.ps1) to your environment.

```
Set-Variable -Name "elastic-version" -Value "8.1.1" 
Set-Variable -Name "elastic-fleet-url" -Value "your-elastic-fleet-url"
Set-Variable -Name "elastic-fleet-policy-enrollment-token" -Value "elastic-fleet-policy-enrollment-token"
```

If you have an OpenVPN configuration and creds, you can populate the variables in [provision.ps1](provision.ps1).

```
Set-Variable -Name "openvpn-username" -Value "your-openvpn-username"
Set-Variable -Name "openvpn-passphrase" -Value "your-openvpn-passphrase"
```

You can copy/paste your OpenVPN into the configuration file located at `c:\program files\openvpn\config\openvpn.ovpn`

### Let's Go

Let's get after it.

```
git clone https://github.com/peasead/windows-10-sandbox-to-elastic.git
cd windows-10-sandbox-to-elastic
vagrant up
```

## Tips

These must be run from the `windows-10-sandbox-to-elastic\` directory on your host.

Connect via RDP (may  have to run twice if RDP program isn't open)
```
vagrant rdp
```

Connect via SSH
```
vagrant ssh
```

Upload malware to box
```
vagrant upload malware.virus "c:\users\vagrant\desktop\malware.virus"
```

Take a snapshot before malware detonation
```
vagrant snapshot save pre-malware
```

Restore a snapshot (to reset back to clean version without having to rebuild)
```
vagrant snapshot restore pre-malware
```

Destroy everything and start over
```
vagrant destroy -f
```

Initiate a VPN connection
Run the `vpn-connect.ps1` file on the Desktop
