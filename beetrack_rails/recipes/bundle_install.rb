node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "#{deploy[:deploy_to]}/current/"
  execute "bundle install" do
    cwd  release_path
    user app_config[:user]
    command "cd #{release_path} && bundle install"
    returns [0,1]
  end
end
