require 'yaml'
require 'pry'
require 'thor'
require 'os'

Dir[File.expand_path "./lib/askew/*.rb"].each do |f|
  require_relative(f)
end
