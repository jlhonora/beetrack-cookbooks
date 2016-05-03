include_recipe "opsworks-elb"

execute "register" do
  command "/usr/bin/env AWS_ACCESS_KEY_ID=#{node['aws']['AWS_ACCESS_KEY_ID']} AWS_SECRET_ACCESS_KEY=#{node['aws']['AWS_SECRET_ACCESS_KEY']} aws elb register-instances-with-load-balancer --load-balancer-name #{node[:aws][:elb][:load_balancer_name]} --instances #{node[:opsworks][:instance][:aws_instance_id]} --region #{node[:opsworks][:instance][:region]}"
  user "ubuntu"
end
