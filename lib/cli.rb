
require 'yaml'
require 'pry'
require 'thor'

Dir[File.expand_path "./lib/**/*.rb"].each{|f| require_relative(f)}

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
      Startup.process_config options[:config]
    end

    no_commands do
      def _get_config_arg
        options[:config]
      end
    end 

  end

end
