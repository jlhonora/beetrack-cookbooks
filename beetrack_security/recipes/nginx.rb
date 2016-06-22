node[:deploy].each do |application, deploy|

  # better avoid collisions
  nginx_config = node[:beetrack_nginx_config]

  use_ssl = nginx_config[:use_ssl] || false
  deploy_path = nginx_config[:deploy_path] || deploy[:deploy_to] # default param
  common_vars = {
    'deploy_path' => deploy_path, # translate legacy config name
    # some defaults
    'app_name' => application,
    'unicorn_stream_name' => "unicorn_#{application}",
    'unicorn_socket' => "#{deploy_path}/shared/sockets/unicorn.sock",
    'public_path' => "#{deploy_path}/current/public",
    'allow_localhost' => false
  }
  nginx_config.each do |k,v|
    common_vars[k.to_s] = v
  end

  fake_root = ''
  posible_fake_root = node[:create_local_templates_on_fake_root]
  if !posible_fake_root.nil? && posible_fake_root.respond_to?(:empty?) && !posible_fake_root.empty?
    fake_root = posible_fake_root
  end

  template "#{fake_root}/etc/nginx/nginx.conf" do
    source 'nginx.conf.erb'
    if fake_root.empty?
      owner 'root'
      group 'root'
      mode 0644
    end
  end


  template "#{fake_root}/etc/nginx/sites-available/beetrack" do
    source 'beetrack.erb'
    if fake_root.empty?
      owner 'root'
      group 'root'
      mode 0644
    end
    variables common_vars.merge({'use_ssl' => false, 'skip_upstream' => false})
  end

  if use_ssl
    template "#{fake_root}/etc/nginx/sites-available/beetrack-ssl" do
      source 'beetrack.erb'
      if fake_root.empty?
        owner 'root'
        group 'root'
        mode 0644
      end
      variables common_vars.merge({'use_ssl' => true, 'skip_upstream' => true, 'allow_localhost' => false})
    end
  end

end
