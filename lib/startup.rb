class Startup

  def self.process_config

    @@config_file = ENV['HOME'] + "/.askew/askew.config"

    @@config = Config.new config_file 

    if !@@config.valid?
      exit 1
    else
    #puts "Loading config from #{config.path}"
    # should we not ask the user if they would like us to create one for them on first run?
    end
  end

  def self.config
    @@config
  end

  def self.config_file
    @@config_file
  end
end

