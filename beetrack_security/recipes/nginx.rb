node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  Chef::Log.info("creating zone in nginx in #{rails_env}")
  ruby_block "create_zone" do
    block do
      file = Chef::Util::FileEdit.new("/etc/nginx/nginx.conf")
      file.insert_line_after_match("/keepalive_timeout  65/", "limit_req_zone $binary_remote_addr zone=one:10m rate=200r/m;")
      file.write_file
    end
  end

  ruby_block "add_limit_req" do
    block do
      Chef::Log.info("creating config nginx beetrack in #{rails_env}")
      file = Chef::Util::FileEdit.new("/etc/nginx/sites-available/beetrack")
      file.search_file_delete_line("/client_max_body_size 10m;/")
      file.search_file_delete_line("/client_body_buffer_size 128k;/")
      file.search_file_delete_line("/limit_req   zone=one  burst=5 nodelay;/")
      file.search_file_delete_line("/proxy_set_header X-Real-IP $remote_addr;/")
      file.insert_line_after_match("/location @unicorn {/", "proxy_set_header X-Real-IP $remote_addr;")
      file.insert_line_after_match("/location @unicorn {/", "client_max_body_size 10m;")
      file.insert_line_after_match("/location @unicorn {/", "client_body_buffer_size 128k;")
      file.insert_line_after_match("/location @unicorn {/", "limit_req   zone=one  burst=5 nodelay;")
      file.write_file
    end
  end
end
