# Default recipe
# JLH, Nov 2014

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

beetrack_templates.each do |t|
  puts "Inflating template #{t}.yml.erb"
  template "/srv/beetrack/shared/config/#{t}.yml" do
    source "#{t}.yml.erb"
    owner  "ubuntu"
    group  "ubuntu"
    mode   "0660"
  end
end
