module Askew
  
  class Task < Thor
    
    desc "list", "List all tasks"
    def list 
      begin
        print get_sorted_list
      rescue Exception => e
        puts "Unable to load your todo list."
        puts e
      end
    end

    #desc "search SEARCH_PHRASE", "Search tasks for SEARCH_PHRASE"
    #def search phrase
    #  list = Todo::List.new Startup.config.todo_file
    #  sorted = list.sort_by {|item| [item.priority ? 0 : 1, item.priority || 0]} # list by priorty with nulls at the end 
    #end

    desc "do TASK_#", "Mark TASK_# as done."
    def do task_num 
      sorted = get_sorted_list
      raw = sorted[task_num.to_i-1].raw
      list = get_list
      list.each do |task|
        task.do! if task.raw == raw #this could complete more than one item if they are exactly the same
        puts "Item #{task_num} has been completed: #{sorted[task_num.to_i-1].raw}" if task.raw == raw
      end
      list.save!
    end

    desc "undo TASK_X", "Mark TASK_# as not done"
    def undo task_num
      sorted = get_sorted_list
      raw = sorted[task_num.to_i-1].raw
      list = get_list
      list.each do |task|
        task.undo! if task.raw == raw #this could qualify duplicates
        puts "Item #{task_num} has been marked incomplete #{sorted[task_num.to_i-1].raw}" if task.raw == raw
      end
      list.save!
    end

    desc "add TASK_INFO", "Add a task"
    def add *task_text
      new_task = Todo::Task.new task_text.join ' '
      list = get_list 
      list << new_task
      list.save! #"#{Startup.config.todo_file}2)"
    end

    desc "remove | rm TASK_#", "Remove a task"
    def remove num
      sorted = get_sorted_list 

      index_to_rm = num.to_i - 1 
      if yes? "[y,yes] Ok to remove task #{num}? : #{sorted[index_to_rm]} \n" 
        list.delete sorted[index_to_rm]
        list.save! 
      end
    end

    no_commands do
     
      def get_sorted_list
        list = get_list 
        sorted = list.sort_by {|item| [item.priority ? 0 : 1, item.priority || 0]} # list by priorty with nulls at the end
      end 

      def get_list
        list = Todo::List.new Startup.config.todo_file
      end

      def print task_list=nil
        return if task_list == nil
      
        task_list.each.with_index do |task,index|
          puts "#{index+1} #{task}" 
        end
      
      end

    end 

    map rm: :remove

    default_task :list

  end

end
