require_relative 'tasklistcommand.rb'

module Askew

  class TaskCommand < CommandBase 

    desc "list", "List tasks/projects/contexts"  
    subcommand "list", Askew::TaskListCommand
    
    desc "do TASK_#", "Mark TASK_# as done."
    def do task_num 
      list = get_list
      list[task_num.to_i].do!
      puts "Item #{task_num} has been completed: #{list[task_num.to_i].raw}"
      list.save!
    end

    desc "undo TASK_#", "Mark TASK_# as not done"
    long_desc <<-LONGDESC
      
      'askew task undo' will mark a task as not done and remove the completion marker(x) and or completion date as necesssary.
       
      Insert ARCHIVE related comments as neeeded?

    LONGDESC
    def undo task_num
      list = get_list

      if !list[task_num.to_i].done?
        puts "Item #{task_num} is not yet completed. No change made."
        return
      end

      list[task_num.to_i].undo! 
      puts "Item #{task_num} has been marked incomplete #{list[task_num.to_i].raw}"
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

    desc "show TASK_#", "Show all the details of a task"
    def show num
      show_task num 
    end

    no_commands do
    
      def show_task num
        list = get_list
        task = list[num.to_i]
        puts ""        
        puts "Poperty            Value"
        puts "----------------------------------------------------"
        puts "ID                 #{num}" 
        puts "Priority           #{task.priority}" if task.priority
        puts "Text               #{task.text}"
        puts "Projects           #{task.projects.join " , " }" if task.projects.any?
        puts "Contexts           #{task.contexts.join " , "}" if task.contexts.any?
        puts "Tags               #{task.tags.map{|k,v| "#{k}:#{v}"}.join(' , ')}" if task.tags.any?
        puts "Created            #{task.created_on}" if task.created_on 
        puts "Completed          #{task.completed_on}" if task.completed_on 
        puts "Raw                #{task.raw}"
        puts ""
      end

      def get_sorted_list
        list = get_list
        sorted = list.sort_by {|key, value| [value.priority ? 0 : 1, value.priority || 0]} # list by priorty with nulls at the end
      end 

      def get_list
        list = Askew::TaskList.new Startup.config.todo_file
      end

      def print_list task_list=nil
        return if task_list == nil
        
        ids = []
        #collect only the line #'s
        task_list.flatten.each_with_index {|item,index| ids << item if index.even?} 
        #find the char count of the biggest line # 
        max = ids.max.to_s.size
        
        task_list.each do |key,value|
          if(value.done?)
            print "#{key.to_s.rjust(max,' ')} #{value.raw}".red.bold
          else
            puts "#{key.to_s.rjust(max,' ')} #{value.raw}" 
          end 
        end
      
      end

    end 

    default_task :list

  end

end
