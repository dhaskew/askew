module Askew
  class TaskList < Array
    def initialize(list)
      case list
      when Array
        tasks = list.map do |item|
          case item
          when String then Task.new(item)
          when Task then item
          else
            raise "Cannot add #{item.class} to list."
          end
        end

        concat(tasks)

      when String
        @path = list
        concat(File.read(list))
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

      File.write(path, self)
    end
  end
end
