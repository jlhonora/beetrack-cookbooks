node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "#{deploy[:deploy_to]}/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  SIDEKIQ_PID = File.expand_path("#{deploy[:deploy_to]}/shared/pids/sidekiq.pid", __FILE__)
  if !( File.exists?(SIDEKIQ_PID) && system("ps x | grep `cat #{SIDEKIQ_PID}` 2>&1 > /dev/null") rescue false)
    execute "rake sidekiq:start" do
      user 'deploy'
      command       "RAILS_ENV=#{rails_env} bundle exec sidekiq -d"
      cwd           release_path
    end
  else
    execute "rake sidekiq:stop" do
      cwd           release_path
      user 'deploy'
      command "RAILS_ENV=#{rails_env} bundle exec sidekiqctl stop #{deploy[:deploy_to]}/shared/pids/sidekiq.pid"
      returns [0,1]
    end
  end
end
