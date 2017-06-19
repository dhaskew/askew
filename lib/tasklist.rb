module Askew
  class TaskList < Hash
    def initialize(list)
      case list
      when Hash
        self.merge! list
      when String
        @path = list
        temp = Askew::File.read(list)
        counter = 1
        temp.each do |task|
          self[counter] = task
          counter += 1
        end
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

    def search term
      matches = {}
      self.each { |key,value| matches[key] = value if value.raw.include? term }
      TaskList.new(matches)
    end

    def by_priority(priority)
      TaskList.new(select { |key,task| task.priority == priority })
    end

    def by_context(context)
      TaskList.new(select { |key,task| task.contexts.include? context })
    end

    def by_project(project)
      TaskList.new(select { |key,task| task.projects.include? project })
    end

    def by_done
      done_tasks = {}
      self.each { |key,value| done_tasks[key] = value if value.done? }
      self.sort_by {|key,value| [value.completed_on ? 0 : 1, value.completed_on || 0]}
      done_tasks
    end

    def by_not_done
      TaskList.new(select { |key,task| task.done? == false })
    end

    def archive_done
      apath = ::File.dirname(@path) + "/done.txt"
      ::File.open(apath, "a+") do |f|
        by_done.each { |key,value| f.write(value.raw) }
      end
    end

    def remove_done!
      self.delete_if { |key,value| value.done?}
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
