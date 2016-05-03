node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "#{deploy[:deploy_to]}/current/"
  Chef::Log.info("shutdown sidekiq #{rails_env}")
  execute "rake sidekiq:quiet" do
    cwd           release_path
    user 'root'
    command "RAILS_ENV=#{rails_env} kill -TERM `cat #{deploy[:deploy_to]}/shared/pids/sidekiq.pid`"
    returns [0,1]
  end
end
