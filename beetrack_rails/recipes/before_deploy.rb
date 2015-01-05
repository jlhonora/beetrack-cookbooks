# Default recipe
# JLH, Nov 2014

include_recipe "deploy"

# Inflate templates
beetrack_templates = ["mongoid", "services_config"]

node[:deploy].each do |application, deploy|
  
  deploy = node[:deploy][application]

  beetrack_templates.each do |t|
    link "#{deploy[:deploy_to]}/shared/config/#{t}.yml" do
      to "#{deploy[:deploy_to]}/current/config/#{t}.yml"
      action :create
    end
  end
end
