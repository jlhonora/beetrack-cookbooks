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
  deploy = node[:deploy][application]

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
