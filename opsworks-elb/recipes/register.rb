include_recipe "opsworks-elb"

execute "register" do
  command "aws elb register-instances-with-load-balancer --load-balancer-name #{node[:aws][:elb][:load_balancer_name]} --instances #{node[:opsworks][:instance][:aws_instance_id]} --region #{node[:opsworks][:instance][:region]} --access-key-id #{node['aws']['AWS_ACCESS_KEY_ID']} --secret-key #{node['aws']['AWS_SECRET_ACCESS_KEY']}"
  user "root"
end
