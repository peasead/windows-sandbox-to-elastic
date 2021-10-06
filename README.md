# Windows 10 Sandbox to Elastic Cloud

This project is aimed at rapidly building a Windows 10 system to use for dynamic malware analysis (sandbox), sending data to Elastic Cloud.

There is always improvements to be had, this may not work for malware with defensive capabilties, but this should get you going. 

Once you spin this up, you'll have:

* Windows 10
* Winlogbeat
* Packetbeat
* Elastic Agent
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

If you need help with the Elastic parts, you can use this [dev (read, **NOT FOR PRODUCTION**) project](https://github.com/peasead/elastic-container) or check out https://elastic.co. The dev project will require some tuning as it runs in Docker, not Elastic Cloud.

### Preparation

Before you run this, you'll need to update the variables in [provision.ps1](provision.ps1) to your environment.

```
Set-Variable -Name "elastic-version" -Value "7.15.0" 
Set-Variable -Name "elastic-fleet-url" -Value "your-elastic-fleet-url"
Set-Variable -Name "elastic-fleet-enrollment-token" -Value "your-elastic-fleet-enrollment-token"
$ProgressPreference = 'SilentlyContinue'

Set-Variable -Name "elastic-username" -Value "your-elastic-stack-username (default is elastic)"
Set-Variable -Name "elastic-passphrase" -Value "your-elastic-passphrase"
Set-Variable -Name "elastic-cloud-id" -Value "your-elastic-cloud-id"
```

### Let's Go

Let's get after it.

```
git clone https://github.com/peasead/windows-10-sandbox-to-elastic.git
cd windows-10-sandbox-to-elastic
vagrant up
```

## Tips

These must be run from the `windows-10-sandbox-to-elastic\` directory.

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

## Troubleshooting

It could be me, but I have noticed in some situations that the box will stall here and eventually time out:

```
 INFO winrmshell:   - Host: 127.0.0.1
 INFO winrmshell:   - Port: 55985
 INFO winrmshell:   - Username: vagrant
 INFO winrmshell:   - Transport: negotiate
 ```

I have opened an [Issue](https://github.com/gusztavvargadr/packer/issues/276) with the Vagrant box owner, but to get around this, you can open up VirtualBox, click on "Show" and log in to the box with `vagrant:vagrant` and the install will finish. Not sure why that is, but that seems to get over this while we wait for a fix...or it could just be me.