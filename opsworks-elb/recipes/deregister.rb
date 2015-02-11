include_recipe "opsworks-elb"

execute "deregister" do
  command "aws elb deregister-instances-from-load-balancer --load-balancer-name #{node[:aws][:elb][:load_balancer_name]} --instances #{node[:opsworks][:instance][:aws_instance_id]} --region #{node[:opsworks][:instance][:region]}"
end
