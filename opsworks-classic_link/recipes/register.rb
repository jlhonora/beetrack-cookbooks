include_recipe "opsworks-classic_link"

execute "register" do
  command "/usr/bin/env AWS_ACCESS_KEY_ID=#{node['aws']['AWS_ACCESS_KEY_ID']} AWS_SECRET_ACCESS_KEY=#{node['aws']['AWS_SECRET_ACCESS_KEY']} aws ec2 attach-classic-link-vpc --instance-id #{node[:opsworks][:instance][:aws_instance_id]}  --vpc-id #{node[:aws][:classic_link][:vpc_id]} --groups #{node[:aws][:classic_link][:groups]} --region #{node[:opsworks][:instance][:region]}"
  user "ubuntu"
end
