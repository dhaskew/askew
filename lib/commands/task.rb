module Askew
  
  class Task < Thor
    
    desc "list", "List all tasks"
    def list 
      begin
        list = Todo::List.new Startup.config.todo_file
        #puts list.by_priority "A"
        #puts list.sort_by { |task| task.priority }
        sorted = list.sort_by {|item| [item.priority ? 0 : 1, item.priority || 0]} # list by priorty with nulls at the end
        sorted.each.with_index do |task,index|
          puts "#{index+1} #{task}" 
        end
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

    desc "remove | rm TASK_#", "Remove a task"
    def remove num
      list = Todo::List.new Startup.config.todo_file
      sorted = list.sort_by {|item| [item.priority ? 0 : 1, item.priority || 0]} # list by priorty with nulls at the end

      index_to_rm = num.to_i - 1 
      if yes? "[y,yes] Ok to remove task #{num}? : #{sorted[index_to_rm]} \n" 
        puts "user confirmed"
        list.delete sorted[index_to_rm]
        list.save! 
      end
    end

    map rm: :remove

    default_task :list

  end

end
