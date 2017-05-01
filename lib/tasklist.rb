module Askew
  class TaskList < Array
    def initialize(list)
      puts list
      @path = list
      concat(Askew::File.read(list))
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
