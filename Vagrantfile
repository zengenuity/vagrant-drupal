# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
config_default = YAML.load_file("#{current_dir}/config/config.default.yml")
conf = config_default['config']
if File.exist?("#{current_dir}/config/config.yml")
  config_local = YAML.load_file("#{current_dir}/config/config.yml")
  conf = conf.merge(config_local['config'])
end

if conf['display_config']
  puts 'Configuration'
  puts YAML::dump(conf)
end

Vagrant.configure(2) do |config|
  
  # Box Settings
  config.vm.box = conf['box']
  config.vm.provider "virtualbox" do |v|
    v.memory = conf['virtualbox']['memory']
    v.cpus = conf['virtualbox']['cpus'] 
    v.customize ["modifyvm", :id, "--ioapic", "on"]
  end
  
  # Network
  if conf['network']['type'] == 'private_network'
    if (conf['network'].has_key? 'ip')
      config.vm.network :private_network, ip: conf['network']['ip']
    else
      config.vm.network "private_network", type: "dhcp"
    end
    config.vm.synced_folder "data/", "/var/data", type: "nfs", mount_options: ['actimeo=1'], create: true
  else
    config.vm.synced_folder "data/", "/var/data", create: true
  end
    
  # Core
  config.vm.provision :shell, path: "provision/core.sh"
  
  # Apache
  if conf['apache']['install']
    config.vm.provision :shell, path: "provision/apache-php.sh"
    
    if conf['network']['type'] == 'private_network'
      config.vm.synced_folder "www/", "/var/www/html", type: "nfs", mount_options: ['actimeo=1']
    else
      config.vm.synced_folder "www/", "/var/www/html", owner: "www-data", group: "www-data", mount_options: ["dmode=775,fmode=664"]
      config.vm.network :forwarded_port, host: 8888, guest: 80
    end
  
  end

  # MySQL
  if conf['mysql']['install']
    config.vm.provision :shell, path: "provision/mysql.sh", args: [ conf['mysql']['password'] ]
  end
  
  # Node Tools
  if conf['node_tools']['install']
    config.vm.provision :shell, path: "provision/node-tools.sh"
  end
  
  # Composer
  if conf['composer']['install']
    config.vm.provision :shell, path: "provision/composer.sh"
  end
  
  # Drush
  if conf['drush']['install']
    config.vm.provision :shell, path: "provision/drush.sh"
  end
  
  # Drupal Console
  if conf['drupal_console']['install']
    config.vm.provision :shell, path: "provision/drupal_console.sh"
  end
  
  # Zsh and Oh-My-Zsh
  if conf['zsh']['install']
    config.vm.provision :shell, path: "provision/zsh.sh"
  end
  
  # Solr
  if conf['solr']['install']
    config.vm.provision :shell, path: "provision/solr.sh"
  end
  
  # Mailhog
  if conf['mailhog']['install']
    config.vm.provision :shell, path: "provision/mailhog.sh", args: [ conf['mailhog']['binary_url'] ]
  end
  
end
