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
    
    default_task :list

  end

end
