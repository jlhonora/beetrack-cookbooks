rails_env = node['rails_env']
ruby_block "configure nginx.conf" do
  block do 
    Chef::Log.info("creating zone in nginx in #{rails_env}")
    file = Chef::Util::FileEdit.new("/etc/nginx/nginx.conf")
    #file.search_file_delete_line(/zone=one:10m rate=200r/)
    file.insert_line_after_match(/keepalive_timeout/, "  limit_req_zone $binary_remote_addr zone=one:10m rate=200r/m;")
    file.write_file
  end
end

ruby_block "configure beetrack nginx" do
  block do 
    Chef::Log.info("creating config nginx beetrack in #{rails_env}")
    file2 = Chef::Util::FileEdit.new("/etc/nginx/sites-available/beetrack")
    #file2.search_file_delete_line(/client_max_body_size 10m/)
    #file2.search_file_delete_line(/client_body_buffer_size 128k/)
    #file2.search_file_delete_line(/limit_req   zone=one  burst=5 nodelay/)
    #file2.search_file_delete_line(/proxy_set_header X-Real-IP $remote_addr;/)
    file2.insert_line_after_match(/location @unicorn/, "    proxy_set_header X-Real-IP $remote_addr;")
    file2.insert_line_after_match(/location @unicorn/, "    client_max_body_size 10m;")
    file2.insert_line_after_match(/location @unicorn/, "    client_body_buffer_size 128k;")
    file2.insert_line_after_match(/location @unicorn/, "    limit_req   zone=one  burst=5 nodelay;")
    file2.write_file
  end
end
