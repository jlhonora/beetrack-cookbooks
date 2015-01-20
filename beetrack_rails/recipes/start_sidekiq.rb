node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "/srv/www/beetrack/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  execute "rake sidekiq:start" do
    command       "bundle exec rake sidekiq:start"
    cwd           release_path
    environment   'RAILS_ENV' => rails_env
  end
end
