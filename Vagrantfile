# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.berkshelf.enabled = true
  config.vm.hostname = "cp-liquibase"

  config.vm.synced_folder "./test/sql", "/vagrant_data"

  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-6.4_chef-11.4.4.box"
  config.vm.box = "platform-centos"
  config.vm.network :forwarded_port, guest: 3306, host: 3306  # MySQL
 
  config.vm.provision :chef_solo do |chef|
    
    chef.log_level = :debug
    chef.json = {
      :mysql => {
        :server_root_password => 'coolmysql1',
        :server_debian_password => 'coolmysql1',
        :server_repl_password => 'coolmysql1',
        :allow_remote_root => true,
        :bind_address => '0.0.0.0'
      },
      :cp_mysql => {
        :run_script => '/vagrant_data/createdb.sql'
      },
      :database => {
        :driver_class => 'com.mysql.jdbc.Driver',
        :jdbc_url => 'jdbc:mysql://localhost:3306/liquibase_test',
        :username => 'root',
        :password => 'coolmysql1'
      },
    }
    chef.add_recipe "cp_java::default"
    chef,add_recipe "cp_mysql::default"
    chef.add_recipe "cp_liquibase::default"
  end
end
