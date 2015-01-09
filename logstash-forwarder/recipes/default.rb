# encoding: UTF-8

execute "echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | sudo tee /etc/apt/sources.list.d/logstashforwarder.list"
execute 'sudo apt-get update'
apt_package "logstash-forwarder" do
  action :install
  options "--force-yes"
end

template node['logstash-forwarder']['config_file'] do
  source 'forwarder.conf.erb'
  owner 'root'
  group 'root'
  notifies :restart, 'service[logstash-forwarder]'
  variables(
    collector_ip: node['logstash-forwarder']['collector_ip'],
    forwarder_port: node['logstash-forwarder']['port'],
    ssl_cert_name: node['logstash-forwarder']['ssl_cert_name'],
    render_template: node['logstash-forwarder']['template'],
    render_cookbook: node['logstash-forwarder']['cookbook'],
    render_files: node['logstash-forwarder']['files']
    
  )
end
