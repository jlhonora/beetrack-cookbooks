node[:deploy].each do |application, deploy|
  execute "unicorn_#{application} restart" do
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
    action :run
  end
  execute "rake sidekiq:start" do
    command       "bundle exec rake sidekiq:start"
    cwd           release_path
  end
end
