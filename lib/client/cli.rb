require 'yaml'
require 'pry'
require 'thor'
require 'os'

Dir[File.expand_path "./lib/client/cli/**/*.rb"].each do |f|
  require_relative(f)
end

module AskewClient

  class CLI < Thor

    class_option 'config', :banner => 'PATH_TO_FILE', :aliases => '-c', :type => :string, :default => nil

    desc "version" ,  "Display the application version"
    subcommand "version", AskewClient::VersionCommand

    desc "task", "List all the tasks"
    subcommand "task", AskewClient::TaskCommand

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
