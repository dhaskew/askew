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
