require 'os'

task :default => :test #by default, run our tests

#run the test suite
task :test do
  Dir.glob('./test/**/*_test.rb').each { |file| require file}
end

#open the test coverage report
task :opencov do
  `#{OS.open_file_command} coverage/index.html`
end
