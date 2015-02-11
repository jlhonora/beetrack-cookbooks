# beetrack-cookbooks
Chef cookbooks for Opsworks

# Rails-Recipes
1. assets precompile
2. Generate mongoid.yml and database.yml (MYSQL)
3. Start/Stop sidekiq

# Security recipes
1. fail2ban (default)
2. nginx req limit

# Logstash-forwarder
* ``` node['logstash-forwarder']['cdn_url'] ``` - Where this package going to be pulled from
* ``` node['logstash-forwarder']['collector_ip'] ``` - What is the IP the forwarder will send to (aka Logstash)
* ``` node['logstash-forwarder']['port'] ``` - What is the Port that the forwarder will communicate to the reciever on
* ``` node['logstash-forwarder']['ssl_cert_name'] ``` - What is the name of the SSL cert that is going to be used
* ``` node['logstash-forwarder']['template'] ``` - What is the name of the template that will be included
* ``` node['logstash-forwarder']['cookbook'] ``` - What is the name of the cookbook that the rendered template resides

# Opsworks ELB register/unregister
