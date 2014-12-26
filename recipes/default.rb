
use_local_file="#{node[:cp_liquibase][:use_local_dist]}"
dist_local_file_path="#{node[:cp_liquibase][:dist_local_file_path]}"

group "#{node['cp_liquibase']['group']}" do
  action :create
end

user node['cp_liquibase']['user'] do
  gid node['cp_liquibase']['group']
  shell "/bin/bash"
  action :create
end

directory "#{node['cp_liquibase']['install_dir']}" do
    mode "0775"
    owner "#{node['cp_liquibase']['user']}"
    group "#{node['cp_liquibase']['group']}"
    action :create
    recursive true
end

directory "#{node['cp_liquibase']['dist_dir']}" do
    mode "0775"
    owner "#{node['cp_liquibase']['user']}"
    group "#{node['cp_liquibase']['group']}"
    action :create
    recursive true
end

remote_file "#{node['cp_liquibase']['install_dir']}/#{node['cp_liquibase']['binary_file_name']}" do
  owner "#{node['cp_liquibase']['user']}"
  group "#{node['cp_liquibase']['group']}"
  source "#{node['cp_liquibase']['url']}"
  action :create_if_missing
end

package "unzip"

bash "extract liquibase" do 
  user "#{node['cp_liquibase']['user']}"
  group "#{node['cp_liquibase']['group']}"
  code <<-EOH
    unzip -o #{node['cp_liquibase']['install_dir']}/#{node['cp_liquibase']['binary_file_name']} -d #{node['cp_liquibase']['install_dir']}
  EOH
end

remote_file "#{node['cp_liquibase']['dist_dir']}/#{node['cp_liquibase']['driver_file_name']}" do
  owner "#{node['cp_liquibase']['user']}"
  group "#{node['cp_liquibase']['group']}"
  source "#{node['cp_liquibase']['driver_jar_url']}"
  action :create_if_missing
end

if "#{node[:cp_liquibase][:use_local_dist]}" == "true" 
  file "#{node['cp_liquibase']['dist_dir']}/sql.zip" do
    owner 'root'
    group 'root'
    mode 0644
    content  ::File.open("#{dist_local_file_path}").read 
    action :create
  end 
else
  bash "deploy sql binary" do
    user "#{node['cp_liquibase']['user']}"
    group "#{node['cp_liquibase']['group']}"
    code <<-EOH
  	  curl -o #{node['cp_liquibase']['dist_dir']}/sql.zip --user #{node['cp_baseconfig']['artifactory']['username']}:#{node['cp_baseconfig']['artifactory']['password']} #{node['cp_liquibase']["sql_binary_url"]}
    EOH
  end
end

bash "extract sql binary" do 
  user "#{node['cp_liquibase']['user']}"
  group "#{node['cp_liquibase']['group']}"
  code <<-EOH
    unzip -o #{node['cp_liquibase']['dist_dir']}/sql.zip -d #{node['cp_liquibase']['dist_dir']}
  EOH
end

bash "execute liquibase" do 
  user "#{node['cp_liquibase']['user']}"
  group "#{node['cp_liquibase']['group']}"
  code <<-EOH
    cd #{node['cp_liquibase']['dist_dir']}
    java -jar #{node['cp_liquibase']['install_dir']}/liquibase.jar --changeLogFile=#{node['cp_liquibase']['dist_dir']}/#{node['cp_liquibase']['zip_foldername']}/changelog.xml --username=#{node['cp_liquibase']['db_user']} --password=#{node['cp_liquibase']['db_password']} --url=#{node['cp_liquibase']['db_url']} --driver=#{node['cp_liquibase']['db_driver']} --classpath=#{node['cp_liquibase']['dist_dir']}/#{node['cp_liquibase']['driver_file_name']} #{node['cp_liquibase']['command']}
  EOH
end

