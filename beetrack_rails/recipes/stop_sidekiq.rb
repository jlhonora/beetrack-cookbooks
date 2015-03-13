node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "/srv/www/beetrack/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  execute "rake sidekiq:stop" do
    user 'root'
    command       "RAILS_ENV=#{rails_env} bundle exec sidekiqctl stop /srv/www/beetrack/shared/pids/sidekiq.pid"
    cwd           release_path
  end
end
