require 'simplecov'

SimpleCov.start do
  add_filter "/test/" # no code coverage on the test files themselves
end

require "minitest/reporters"
#Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true), Minitest::Reporters::SpecReporter.new()]
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new()]
require "minitest/autorun"
require "thor"
require "pry"
Dir[File.expand_path "./lib/**/*.rb"].each{|f| require_relative(f)}

require "fakefs/safe"
