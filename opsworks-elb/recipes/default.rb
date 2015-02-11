## cookbooks/aws/recipes/default.rb
execute "aws-cli" do
  command "sudo apt-get -y install awscli"
  action :run
end
