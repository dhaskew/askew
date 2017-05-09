

#
# We monkey patch the print_wrapped function of thor because it doesn't wrap
# the terminal in a predictable way. This function is only really used by the
# long_desc function.  This implementation will print the long_desc as written
# and will not do any magic, rightly or wrongly.
#
class Thor
  module Shell
    class Basic
      def print_wrapped(message, options = {})
        stdout.puts message
      end
    end
  end
end

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
