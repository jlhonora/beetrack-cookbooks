include_recipe "opsworks-elb"

execute "register" do
  command "aws elb register-instances-with-load-balancer --load-balancer-name #{node[:aws][:elb][:load_balancer_name]} --instances #{node[:opsworks][:instance][:aws_instance_id]} --region #{node[:opsworks][:instance][:region]}"
end
