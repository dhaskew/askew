# @markup ruby 

require 'os'
require 'yard'

desc "Run the default task / run the tests"
task :default => "test:run" #by default, run our tests

desc "Run all clean tasks"
task :clean => ["doc:clean", "test:clean"]

namespace :test do

  desc "Run the test suite"
  task :run do
    Dir.glob('./test/**/*_test.rb').each { |file| require file}
  end

  desc "Open the test coverage report"
  task :opencov do
    `#{OS.open_file_command} coverage/index.html`
  end

  desc "Cleanup testing outputs"
  task :clean do
    rm_rf "coverage"
  end

end

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

