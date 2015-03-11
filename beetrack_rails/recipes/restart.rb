node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "/srv/www/beetrack/current/"
  execute "unicorn_#{application} restart" do
    user 'deploy'
    group 'deploy'
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
    action :run
  end
  execute "rake sidekiq:start" do
    command       "bundle exec rake sidekiq:start"
    cwd           release_path
    action :run
  end
end
