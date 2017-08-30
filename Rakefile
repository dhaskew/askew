# @markup ruby 

require 'os'
require 'yard'

desc "Run the default task / run the tests"
task :default => "test:run" #by default, run our tests

desc "Run all clean tasks"
task :clean => ["doc:clean", "test:clean"]

load './tasks/testing.rake'
load './tasks/docs.rake'

desc "Remove and recreate documentation"
task :doc => ["doc:clean","doc:yard"]
