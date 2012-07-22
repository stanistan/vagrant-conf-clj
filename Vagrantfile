# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.box = "lucid32"
  config.vm.network :bridged
  config.vm.share_folder "v-data", "/home/vagrant/share", "share"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options = ["--modulepath", "modules"]
  end

end
