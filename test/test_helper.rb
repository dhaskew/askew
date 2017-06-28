require 'simplecov'

SimpleCov.start do
  add_filter "/test/" # no code coverage on the test files themselves
  add_group "libs" do |src_file|
    File.dirname(src_file.filename).end_with? 'lib'
  end
  add_group "thor commands", "lib/commands"
end

require "minitest/reporters"
#Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true), Minitest::Reporters::SpecReporter.new()]
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new()]
require "minitest/autorun"
require "thor"
require "pry"


require_relative '../lib/askew.rb'
require_relative '../lib/cli.rb'

#Dir[File.expand_path "./lib/**/*.rb"].each{|f| require_relative(f)}
