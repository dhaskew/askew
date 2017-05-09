module Askew
  class TaskList < Hash
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

    def projects
      projects = []
      self.each { |key,value| projects << value.projects }
      projects.flatten.uniq
    end

    def contexts
      contexts = []
      self.each { |key,value| contexts << value.contexts }
      contexts.flatten.uniq 
    end

    def for_project project
      project_tasks = {}
      self.each { |key,value| project_tasks[key] = value if value.projects.include? project }
      project_tasks
    end

    def for_context context
      context_tasks = {}
      self.each { |key,value| context_tasks[key] = value if value.contexts.include? context }
      context_tasks
    end

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
      
      self.backup
      Askew::File.write(path, self.values)
    end

    def backup
      ::FileUtils::copy_file(@path,@path + ".bak")
    end
  end
end
