node[:deploy].each do |application, deploy|
  release_path = "#{deploy[:deploy_to]}/current/"
  username = deploy[:user]
  execute "bundle install" do
    cwd  release_path
    user username
    command "cd #{release_path} && bundle install --path /home/#{username}/.bundler/#{application}"
    returns [0,1]
  end
end
