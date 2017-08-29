# @markup ruby 

require 'os'
require 'yard'

desc "Run the default task / run the tests"
task :default => "test:run" #by default, run our tests

desc "Run all clean tasks"
task :clean => ["doc:clean", "test:clean"]

load './tasks/testing.rake'

namespace :doc do

  # Creates the 'rake yard' task
  #
  desc "Create yard documentation"
  YARD::Rake::YardocTask.new

  desc "Cleanup the old yard documentation"
  task :clean do
    rm_rf "doc"
  end

end

