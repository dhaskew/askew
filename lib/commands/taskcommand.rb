module Askew
  
  class TaskCommand < Thor
    
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
      new_task = Askew::Task.new task_text.join ' '
      list = get_list
      list[list.count + 1] = new_task
      list.save!
    end

    map rm: :remove
    
    desc "remove | rm TASK_#", "Remove a task"
    def remove num
      list = get_list 
      index_to_rm = num.to_i
      if yes? "[y,yes] Ok to remove task #{num}? : #{list[index_to_rm].raw}" 
        list.delete(index_to_rm)
        list.save! 
      end
    end

    no_commands do
     
      def get_sorted_list
        list = get_list#.by_not_done
        sorted = list.sort_by {|key, value| [value.priority ? 0 : 1, value.priority || 0]} # list by priorty with nulls at the end
      end 

      def get_list
        list = Askew::TaskList.new Startup.config.todo_file
      end

      def print task_list=nil
        return if task_list == nil
      
        task_list.each do |key,value|
          puts "#{key} #{value.raw}" 
        end
      
      end

    end 

    default_task :list

  end

end
