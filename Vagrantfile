Vagrant.configure("2") do |config|
  
  config.vm.define "windows-victim", primary: true do |cfg|
    cfg.vm.box = "gusztavvargadr/windows-10"
    cfg.vm.hostname = "local-cattle-#{rand(01..99)}"
    cfg.vm.synced_folder ".", "C:\vagrant", disabled: true
    cfg.vm.provision "file", source: "winlogbeat.yml", destination: "c:\\users\\vagrant\\desktop\\winlogbeat.yml"
    cfg.vm.provision "file", source: "packetbeat.yml", destination: "c:\\users\\vagrant\\desktop\\packetbeat.yml"
    cfg.vm.provision "file", source: "openvpn-auth.conf", destination: "c:\\users\\vagrant\\desktop\\openvpn-auth.conf"
    cfg.vm.provision "file", source: "vpn-connect.ps1", destination: "c:\\users\\vagrant\\desktop\\vpn-connect.ps1"
    cfg.vm.provision "provision-script", type: "shell", path: "provision.ps1"
    cfg.vm.provision "file", source: "openvpn.ovpn", destination: "c:\\program files\\OpenVPN\\config\\openvpn.ovpn"
    cfg.vm.provider :virtualbox do |vb|
        vb.name = "local-cattle-#{rand(01..99)}"
        vb.memory = 12288
        vb.cpus = 4
    end
  end
end
