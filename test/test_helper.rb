require 'simplecov'

SimpleCov.start do
  add_filter "/test/" # no code coverage on the test files themselves
  add_group "libs" do |src_file|
    File.dirname(src_file.filename).end_with? 'lib'
  end
  add_group "askew" do |src_file|
    File.dirname(src_file.filename).end_with? 'askew'
  end
  add_group "client" do |src_file|
    File.dirname(src_file.filename).include? 'client'
  end
  add_group "thor commands", "lib/client/cli/commands"
end

require "minitest/reporters"
#Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true), Minitest::Reporters::SpecReporter.new()]
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new()]
require "minitest/autorun"

require_relative '../lib/askew.rb'
require_relative '../lib/client.rb'
