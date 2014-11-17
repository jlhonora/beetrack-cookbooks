# Default recipe
# JLH, Nov 2014

include_recipe "deploy"

# Required packages
package "vim"
package "ntp"
package "git-core"
package "imagemagick"
package "mysql-common"
package "libcurl4-openssl-dev"
package "libmagickwand-dev"
package "libmysqlclient-dev "
package "libv8-dev"
package "libxml2-dev"

# Inflate templates
beetrack_templates = ["database", "mongoid", "services_config"]

node[:deploy].each do |application, deploy|
  node.default[:deploy][application][:database][:adapter] = 
    OpsWorks::RailsConfiguration.determine_database_adapter(
      application, 
      node[:deploy][application],
      "#{node[:deploy][application][:deploy_to]}/current",
      :force => node[:force_database_adapter_detection])
  
  deploy = node[:deploy][application]

  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]
    action :nothing
  end

  beetrack_templates.each do |t|
    puts "Inflating template #{t}.yml.erb"
    template "#{deploy[:deploy_to]}/shared/config/#{t}.yml" do
      source "#{t}.yml.erb"
      cookbook "rails"
      group deploy[:group]
      owner deploy[:user]
      mode   "0664"
    end
  end
end
