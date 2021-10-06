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

Before you run this, you'll need to update the variables in `[provision.ps1](provision.ps1)` to your environment.

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
git clone https://github.com/peasead/windows-10-elastic-sandbox.git
cd windows-10-elastic-sandbox
vagrant up
```

It'll take a while, but once you're done, you'll be able to run `vagrant rdp` (if you don't already have your RDP program open, you may need to run it twice) to access your sandbox and it should be enrolled in your provided Fleet and Elastic Cloud account with Packetbeat and Winlogbeat.

## Troubleshooting

It could be me, but I have noticed in some situations that the box will stall here and eventually time out:

```
 INFO winrmshell:   - Host: 127.0.0.1
 INFO winrmshell:   - Port: 55985
 INFO winrmshell:   - Username: vagrant
 INFO winrmshell:   - Transport: negotiate
 ```

I have opened an [Issue](https://github.com/gusztavvargadr/packer/issues/276) with the Vagrant box owner, but to get around this, you can open up VirtualBox, click on "Show" and log in to the box with `vagrant:vagrant` and the install will finish. Not sure why that is, but that seems to get over this while we wait for a fix...or it could just be me.