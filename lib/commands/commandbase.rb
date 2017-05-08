module Askew
  
  class CommandBase < Thor

    def self.banner(command, namespace = nil, subcommand = false)
      "#{basename} #{subcommand_prefix} #{command.usage}"
    end

    def self.subcommand_prefix
      self.name.split('::').last.downcase.gsub(/command/,'')    
    end

  end
end
