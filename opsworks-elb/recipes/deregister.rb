include_recipe "opsworks-elb"

execute "aws-key" do
  command "export AWS_ACCESS_KEY_ID=#{node['aws']['AWS_ACCESS_KEY_ID']}"
  user 
  action :run
end

execute "aws-pwd" do
  command "export AWS_SECRET_ACCESS_KEY=#{node['aws']['AWS_SECRET_ACCESS_KEY']}"
  action :run
end

execute "deregister" do
  command "aws elb deregister-instances-from-load-balancer --load-balancer-name #{node[:aws][:elb][:load_balancer_name]} --instances #{node[:opsworks][:instance][:aws_instance_id]} --region #{node[:opsworks][:instance][:region]}"
end
