node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  Chef::Log.info("Precompiling Rails assets with environment #{rails_env}")

  execute "rake i18n:js:export" do
    command       "bundle exec rake i18n:js:export"
    cwd           release_path
    environment   'RAILS_ENV' => rails_env
  end

  execute "rake assets:precompile" do
    command       "bundle exec rake assets:precompile"
    cwd           release_path
    environment   'RAILS_ENV' => rails_env
  end
end
