module Askew
  
  class Task < Thor
    
    desc "list", "List all tasks"
    def list 
      begin
        list = Todo::List.new Startup.config.todo_file
        #puts list.by_priority "A"
        #puts list.sort_by { |task| task.priority }
        puts list.sort_by {|item| [item.priority ? 0 : 1, item.priority || 0]} # list by priorty with nulls at the end
      rescue
        puts "Unable to load your todo list."
      end
    end

    desc "add TASK_INFO", "Add a task"
    def add *task_text
      new_task = Todo::Task.new task_text.join ' '
      list = Todo::List.new Startup.config.todo_file
      list << new_task
      list.save! #"#{Startup.config.todo_file}2)"
    end

    default_task :list

  end

end
