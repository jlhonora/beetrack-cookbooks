node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  release_path = "#{deploy[:deploy_to]}/current/"
  execute "rake sidekiq:stop" do
    cwd           release_path
    user 'root'
    command "RAILS_ENV=#{rails_env} bundle exec sidekiqctl stop #{deploy[:deploy_to]}/shared/pids/sidekiq.pid"
    returns [0,1]
  end

  execute "rake sidekiq:start" do
    user 'root'
    command       "RAILS_ENV=#{rails_env} bundle exec sidekiq -d"
    cwd           release_path
  end
  execute "sudo chmod -R 776 #{release_path}" do
  end
  execute "sudo chown deploy -R  #{release_path}" do
  end
end
