# @markup ruby 

require 'os'
require 'yard'

desc "Run the default task / run the tests"
task :default => "test:run" #by default, run our tests

namespace :test do

  desc "Run the test suite"
  task :run do
    Dir.glob('./test/**/*_test.rb').each { |file| require file}
  end

  desc "Open the test coverage report"
  task :opencov do
    `#{OS.open_file_command} coverage/index.html`
  end

end

namespace :doc do

  # Creates the 'rake yard' task
  #
  desc "Create yard documentation"
  YARD::Rake::YardocTask.new

  desc "Cleanup the old yard documentation"
  task :clean do
    puts "This does nothing. It should delete the doc/ director. FINISH THIS"
  end

end

