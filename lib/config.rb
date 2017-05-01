
require 'yaml'

module Askew

  class Config

    attr_reader :path, :todo_file

    def initialize(path)
      @path = path
      @valid = false
      begin
        config = YAML.load(::File.open(path))
        if config.include? 'user'
          name = config['user']['name'] if config['user'].include? 'name'
        end

        if config.include? 'data'
          base_dir = config['data']['todo_base_dir'] if config['data'].include? 'todo_base_dir'
          if base_dir 
            @todo_file = base_dir + config['data']['todo_file'] if config['data'].include? 'todo_file'
          end
        end
        
        @valid = true
      rescue ArgumentError => e
        puts "Could not parse YAML: #{e.message}"
      rescue Exception => e
        puts "Unable to load config from: #{path}" 
        puts "Exception : #{e.message}"
      end
    end 

    def valid?
      @valid 
    end

  end

end
