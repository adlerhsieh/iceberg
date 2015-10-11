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

# Validation
unless path_valid?
  puts "Error: You're not in project root directory".colorize(:red).to_s
  abort("* Make sure you're in a Crystal project root directory.")
end

dir = Dir.working_directory.split("/")[-1]

# Controller
unless Dir.exists?("src/controllers")
  Dir.mkdir("src/controllers")
  created("/src/controllers")
end

File.write("./src/controllers/app_controller.cr",
"require \"iceberg\"\n
class AppController < Iceberg::Controller\n
  def index
  end
end")
created("/src/controllers/app_controller.cr")

# View
unless Dir.exists?("src/views")
  Dir.mkdir("src/views")
  created("/src/views")
end

unless Dir.exists?("src/views/app")
  Dir.mkdir("src/views/app")
  created("/src/views/app")
end

File.write("./src/views/app/index.cr",
"require \"iceberg\"\n
class AppIndexView < Iceberg::View\n
  def process
  end
  html :app, :index
end")
created("/src/views/app/index.cr")

unless Dir.exists?("src/views/app/html")
  Dir.mkdir("src/views/app/html")
  created("/src/views/app/html")
end

File.write("./src/views/app/html/index.ecr","")
created("/src/views/app/html/index.ecr")

# Config
File.write("./src/config.cr",
"require \"./controllers/*\"
require \"./views/*\"
require \"./routes\"

app = Iceberg::App.new
app.run
")
created("/src/config.cr")

# Routes
File.write("./src/routes.cr",
"Iceberg::Router.draw do\n
end
")
created("/src/routes.cr")

# Server executable
File.write("./server",
"#!/bin/bash
result=${PWD##*/}
crystal src/$result.cr
")
%x[chmod +x server]
created("server")

puts "Start a server: ./server"
