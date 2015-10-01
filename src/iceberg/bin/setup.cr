require "colorize"

def path_valid?
  File.file?("shard.yml") &&
  Dir.exists?(".shards") &&
  Dir.exists?("src") &&
  Dir.exists?("spec")
end

def created(message)
  puts "#{"Created:".colorize(:green)} #{message}"
end

def overwritten(message)
  puts "#{"Overwritten:".colorize(:blue)} #{message}"
end

unless path_valid?
  puts "Error: You're not in project root directory".colorize(:red).to_s
  abort("* Make sure you're in a Crystal project root directory.")
end

dir = Dir.working_directory.split("/")[-1]

unless Dir.exists?("src/#{dir}/controllers")
  Dir.mkdir("src/#{dir}/controllers")
  created("/src/#{dir}/controllers")
end

unless Dir.exists?("src/#{dir}/views")
  Dir.mkdir("src/#{dir}/views")
  created("/src/#{dir}/views")
end

File.write("./src/#{dir}/controllers/app_controller.cr",
"require \"iceberg\"\n
class AppController < Iceberg::Controller\n
end")
created("/src/#{dir}/controllers/app_controller.cr")

File.write("./src/#{dir}/config.cr",
"require \"./controllers/*\"
require \"./views/*\"
require \"./routes\"

app = Iceberg::App.new
app.run
")
created("/src/#{dir}/config.cr")

File.write("./src/#{dir}/routes.cr",
"Iceberg::Router.draw do\n
end
")
created("/src/#{dir}/routes.cr")

File.write("./server",
"#!/bin/bash
result=${PWD##*/}
crystal src/$result.cr
")
%x[chmod +x server]
created("server")

puts "Start a server: ./server"
