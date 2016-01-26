include_recipe "opsworks-classic_link"


execute "deregister" do
  command "/usr/bin/env AWS_ACCESS_KEY_ID=#{node['aws']['AWS_ACCESS_KEY_ID']} AWS_SECRET_ACCESS_KEY=#{node['aws']['AWS_SECRET_ACCESS_KEY']} ec2 detach-classic-link-vpc --instance-id #{node[:opsworks][:instance][:aws_instance_id]}  --vpc-id #{node[:aws][:classic_link][:vpc_id]}"
  user "ubuntu"
end
