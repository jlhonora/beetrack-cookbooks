# Uses YAML config files to generate custom JSONs
# JLH, Nov. 2014

require 'yaml'
require 'json'

app_folder  = "../beetrack"
environment = "production"
files       = ["config/database.yml", "config/mongoid.yml", "config/services_config.yml"]

result = Hash.new
files.each do |f|
  loaded = YAML.load_file("#{app_folder}/#{f}")
  puts "#{f}"
  parent = f.split("/").last.split(".").first
  result[parent] = loaded[environment]
  puts loaded[environment].to_json
  puts ""
end

puts JSON.pretty_generate(result)
