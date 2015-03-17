node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "#{deploy[:deploy_to]}/current/"
  execute "unicorn_#{application} restart" do
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
    action :run
  end
end
