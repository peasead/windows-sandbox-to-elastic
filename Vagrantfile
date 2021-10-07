Vagrant.configure("2") do |config|
  
  config.vm.define "windows-victim", primary: true do |cfg|
    cfg.vm.box = "StefanScherer/windows_10"
    cfg.vm.box_version = "2021.08.17"
    cfg.vm.hostname = "local-cattle-#{rand(01..99)}"
    cfg.vm.synced_folder ".", "C:\vagrant", disabled: true
    cfg.vm.provision "file", source: "winlogbeat.yml", destination: "c:\\users\\vagrant\\desktop\\winlogbeat.yml"
    cfg.vm.provision "file", source: "packetbeat.yml", destination: "c:\\users\\vagrant\\desktop\\packetbeat.yml"
    cfg.vm.provision "provision-script", type: "shell", path: "provision.ps1"
    cfg.vm.provider :virtualbox do |vb|
        vb.name = "local-cattle-#{rand(01..99)}"
        vb.memory = 12288
        vb.cpus = 4
    end
  end
end
