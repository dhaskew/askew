
require 'thor'

module Askew

  class Version < Thor

    desc "all", "Print all the components of the application version"
    def all 
      puts VERSION 
    end

    desc "major", "Print only the major version of the application version"
    def major
      puts VERSION_MAJOR
    end
    
    desc "minor", "Print only the minor version of the application version"
    def minor
      puts VERSION_MINOR
    end
    
    desc "patch", "Print only the patch version of the application version"
    def patch
      puts VERSION_PATCH
    end
    
    default_task :all
  end

end
