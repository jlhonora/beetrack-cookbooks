application = node[:deploy][:application_name]

node[:deploy].each do |application, deploy|

  Chef::Log.info "Deploying #{application} using ownlocal_deploy::default"

  include_recipe "apache2::uninstall"
  include_recipe "nginx"
  include_recipe "unicorn"

  opsworks_deploy_user do
    deploy_data deploy
  end

  opsworks_deploy_dir do
    user deploy[:user]
    path deploy[:deploy_to]
  end

  opsworks_rails do
    deploy_data deploy
    app application
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  nginx_web_app application do
    Chef::Log.debug("Calling nginx_web_app with #{deploy}")
    application deploy
    cookbook "nginx"
  end
  
  execute "unicorn_#{application}" do
    cwd deploy[:current_path]
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn start"
    action :run
  end

  unicorn_web_app do
    application application
    deploy deploy
  end
end
