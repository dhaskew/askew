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
