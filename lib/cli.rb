require 'yaml'
require 'pry'
require 'thor'
require 'os'

Dir[File.expand_path "./lib/**/*.rb"].each do |f|
  if !f.include? 'askew.rb'
    if !f.include? 'client.rb'
      if !f.include? 'lib/askew/'
        if !f.include? 'lib/client/'
          require_relative(f)
        end
      end 
    end 
  end
end

module Askew

  class CLI < Thor

    class_option 'config', :banner => 'PATH_TO_FILE', :aliases => '-c', :type => :string, :default => nil

    desc "version" ,  "Display the application version"
    subcommand "version", Askew::VersionCommand

    desc "task", "List all the tasks"
    subcommand "task", Askew::TaskCommand

    default_task :task

    def initialize(*args)
      super
      begin
        Startup.process_config options[:config]
      rescue Exception
        #https://airbrake.io/blog/ruby-exception-handling/systemexit
        puts "Unable to load a valid configuration!"
        #exit 1
      end
    end

  end

end
