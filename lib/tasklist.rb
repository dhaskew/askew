module Askew
  class TaskList < Hash #Array
    def initialize(list)
      @path = list
      temp = Askew::File.read(list)
      counter = 1 
      temp.each do |task|
        self[counter] = task
        counter += 1
      end 
    end

    attr_reader :path

    def by_priority(priority)
      TaskList.new(select { |task| task.priority == priority })
    end

    def by_context(context)
      TaskList.new(select { |task| task.contexts.include? context })
    end

    def by_project(project)
      TaskList.new(select { |task| task.projects.include? project })
    end

    def by_done
      TaskList.new(select(&:done?))
    end

    def by_not_done
      TaskList.new(select { |task| task.done? == false })
    end

    def save!
      raise "No path specified." unless path

      Askew::File.write(path, self)
    end
  end
end
