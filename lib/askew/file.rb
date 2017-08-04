module Askew

  class File

    def self.open(path, mode = 'r')
      ios = new(path, mode)
      
      if block_given?
        yield ios
        return ios.close
      end

      ios
    end

    def self.read(path)
      list = []

      open(path) do |file|
        file.each_task do |task|
          list << task
        end
      end

      list
    end

    def self.write(path, list)
      open(path, 'w') do |file|
        list.each do |task|
          file.puts(task)
        end
      end
    end

    def initialize(path, mode = 'r')
      @ios = ::File.open(path, mode)
    end

    def each
      return enum_for(:each) unless block_given?

      @ios.each_line do |line|
        yield Askew::Task.new(line)
      end
    end

    alias each_task each

    def puts(*tasks)
      @ios.puts(tasks.map(&:to_s))
    end

    def close
      @ios.close
    end
  end
end
