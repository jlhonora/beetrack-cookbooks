node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "/srv/www/beetrack/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  execute "rake sidekiq:start" do
    user 'root'
    command       "bundle exec rake sidekiq:start RAILS_ENV=#{rails_env}"
    cwd           release_path
  end
end
