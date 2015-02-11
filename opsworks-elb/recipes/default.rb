## cookbooks/aws/recipes/default.rb
execute "aws-key" do
  command "export AWS_ACCESS_KEY_ID=#{node['aws']['AWS_ACCESS_KEY_ID']}"
  action :run
end

execute "aws-pwd" do
  command "export AWS_SECRET_ACCESS_KEY=#{node['aws']['AWS_SECRET_ACCESS_KEY']}"
  action :run
end

execute "aws-cli" do
  command "sudo apt-get -y install awscli"
  user "root"
  action :run
end
