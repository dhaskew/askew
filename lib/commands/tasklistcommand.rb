module Askew

  class TaskListCommand < CommandBase
 
    def self.subcommand_prefix
      "task list"    
    end
   
    desc "projects", "List all known projects"
    def projects
      puts get_list.projects.sort
    end

    desc "contexts", "List all known contexts"
    def contexts
      puts get_list.contexts.sort
    end

    desc "all", "List all tasks"
    def all 
      begin
        print_list get_sorted_list
      rescue Exception => e
        puts "Unable to load your todo list."
        puts e
      end
    end

    desc "search TERM", "List all tasks that contain TERM"
    def search term
      print_list get_list.search term 
    end

    desc "for_project X", "List all tasks connected to project X"
    def for_project proj
      print_list get_list.for_project proj
    end

    desc "for_context X", "List all tasks connected to context X"
    def for_context con
      print_list get_list.for_context con
    end


    no_commands do   
      
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

        puts ""
        puts "#{'#'.rjust(max, ' ')} Pri  Created     Task"
        puts "-"*150

        task_list.each do |key,value|

          num = "#{key.to_s.rjust(max,' ')}" 

          pri = "   "
          pri = "(#{value.priority})" if value.priority != nil

          line = "#{num} #{pri} #{value.created_on}  #{value.text}"
          
          puts line

          next

          if(value.done?)
            puts "#{key.to_s.rjust(max,' ')} #{value.raw.sub("\n","")}".red.bold
          else
            puts "#{key.to_s.rjust(max,' ')} #{value.raw}" 
          end 
        end

        footer = "-"*150
        puts footer
        footer = "Task Count: #{task_list.count}"
        puts footer
        puts ""
      end

    end

   default_task :all 

  end


end
