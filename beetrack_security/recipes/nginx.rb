node[:deploy].each do |application, deploy|
  template '/etc/nginx/nginx.conf' do
    source 'nginx.conf.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

  template '/etc/nginx/sites-available/beetrack' do
    source 'beetrack.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(
      deploy: deploy
    )
  end

end
