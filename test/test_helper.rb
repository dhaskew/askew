require 'simplecov'

SimpleCov.start do
  add_filter "/test/" # no code coverage on the test files themselves
end

require "minitest/reporters"
Minitest::Reporters.use!
require "minitest/autorun"
require "thor"
Dir[File.expand_path "./lib/**/*.rb"].each{|f| require_relative(f)}

