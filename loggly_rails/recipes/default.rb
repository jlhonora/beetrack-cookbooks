#
# Cookbook Name:: loggly_rails
# Recipe:: default
# Author:: John Owen
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

templates = {
  'rsyslog-loggly.conf.erb' => '/etc/rsyslog.d/22-loggly.conf',
  'rsyslog-rails.conf.erb' => '/etc/rsyslog.d/21-rails.conf'
}

include_recipe "rsyslog::default"

# rsyslogd must have this line:
bash "set '$MaxMessageSize 64k' to rsyslog.conf" do
  code <<-BASH
  if  grep -q '$MaxMessageSize' "/etc/rsyslog.conf"; then
		sed -i 's/.*$MaxMessageSize.*/$MaxMessageSize 64k/g' /etc/rsyslog.conf
	else
	  sed -i '1 a $MaxMessageSize 64k' /etc/rsyslog.conf
	fi
  BASH
end

templates.each do |src,dst|

  template dst do
    source src
    owner 'root'
    group 'root'
    mode 0644
    variables({
      account: node['loggly']['account'],
      token: node['loggly']['token']
    })
  end

end

notifies :restart, 'service[rsyslog]', :inmediate


