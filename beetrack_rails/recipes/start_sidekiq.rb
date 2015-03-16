node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "/srv/www/beetrack/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  SIDEKIQ_PID = File.expand_path("/srv/www/beetrack/shared/pids/sidekiq.pid", __FILE__)
  if !( File.exists?(SIDEKIQ_PID) && system("ps x | grep `cat #{SIDEKIQ_PID}` 2>&1 > /dev/null") rescue false)
    execute "rake sidekiq:start" do
        user 'root'
        command       "RAILS_ENV=#{rails_env} bundle exec sidekiq -d"
      cwd           release_path
    end
  end
end
