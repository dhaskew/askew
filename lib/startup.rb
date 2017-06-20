module Askew

  class Startup

    def self.process_config optional_config=nil

      @@config_file = optional_config != nil ? optional_config : ENV['HOME'] + "/.askew/askew.config"

      @@config = Config.new config_file

      raise "No Valid Config" if !@@config.valid?

    end

    def self.config
      @@config ||= nil
    end

    def self.config_file
      @@config_file ||= nil
    end
  end

end
