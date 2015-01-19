# Default recipe
# JLH, Nov 2014


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

  template "#{deploy[:deploy_to]}/shared/log/logstash_production.log" do
      source "logstash_production.log.erb"
      cookbook "beetrack_rails"
      group 'root'
      owner 'root'
      mode   "0666"
  end

  beetrack_templates.each do |t|
    puts "Inflating template #{t}.yml.erb"
    template "#{deploy[:deploy_to]}/shared/config/#{t}.yml" do
      source "#{t}.yml.erb"
      cookbook "beetrack_rails"
      group 'root'
      owner 'root'
      mode   "0755"
    end
  end
  
end
