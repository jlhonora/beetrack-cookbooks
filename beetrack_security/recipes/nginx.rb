node[:deploy].each do |application, deploy|


  template '/etc/nginx/nginx.conf' do
    source 'nginx.conf.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

  # better avoid collisions
  nginx_config = deploy[:beetrack_nginx_config]

  use_ssl = nginx_config[:use_ssl] || false
  deploy_path = nginx_config[:deploy_path] || deploy[:deploy_to] # default param
  common_vars = {
    deploy_path: deploy_path, # translate legacy config name
    # some defaults
    app_name: application,
    unicorn_stream_name: "unicorn_#{application}",
    unicorn_socket: "#{deploy_path}/shared/sockets/unicorn.sock",
    public_path: "#{deploy_path}/current/public",
    allow_localhost: false,
  }.merge(nginx_config)

  template '/etc/nginx/sites-available/beetrack' do
    source 'beetrack.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables common_vars.merge({use_ssl: false})
  end

  if use_ssl
    template '/etc/nginx/sites-available/beetrack-ssl' do
      source 'beetrack.erb'
      owner 'root'
      group 'root'
      mode 0644
      variables common_vars.merge({use_ssl: true})
    end
  end

end
