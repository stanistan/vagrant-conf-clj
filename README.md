vagrant-conf-clj
================

Vagrant file and puppet manifest for a clojure VM

### Set up Instructions

1. Download and install [vagrant](http://vagrantup.com/).

2. Make a directory to house your vms.

   ```sh
   mkdir ~/vms
   cd ~/vms
   ```

3. Clone this repo

   ```sh
   git clone git@github.com:stanistan/vagrant-conf-clj.git
   cd vagrant-conf-clj
   ```

4. Set up vagrant (you only need to do this the first time to add the base VM)

   ```sh
   vagrant box add lucid32 http://files.vagrantup.com/lucid32.box
   ```

5. Run the vm

   ```sh
   vagrant up
   ```

---

Now you have a VM running with `lein`, `clojure`, `vimclojure`
