node[:deploy].each do |application, deploy|

  Chef::Log.info "Shutdown #{application} using ownlocal_deploy::default"

  include_recipe "apache2::uninstall"
  include_recipe "nginx"
  include_recipe "unicorn"

  execute "unicorn_#{application}" do
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn stop"
    action :run
  end
end
