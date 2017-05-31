module Askew

  class TaskListCommand < CommandBase
 
    def self.subcommand_prefix
      "task list"    
    end

    desc "projects", "List all known projects"
    def projects
      puts ListManager.get_list.projects.sort
    end

    desc "contexts", "List all known contexts"
    def contexts
      puts ListManager.get_list.contexts.sort
    end

    desc "all", "List all tasks"
    def all 
      begin
        Console.print_list ListManager.get_sorted_list
      rescue Exception => e
        puts "Unable to load your todo list."
        puts e
      end
    end

    desc "search TERM", "List all tasks that contain TERM"
    def search term
      list_for_search = ListManager.get_list.search term
      sorted_list = ListManager.sort_by_priority list_for_search
      Console.print_list sorted_list
    end

    desc "for_project X", "List all tasks connected to project X"
    def for_project proj
      list_for_proj = ListManager.get_list.for_project proj
      sorted_list = ListManager.sort_by_priority list_for_proj
      Console.print_list sorted_list
    end

    desc "for_context X", "List all tasks connected to context X"
    def for_context con
      list_for_con = ListManager.get_list.for_context con
      sorted = ListManager.sort_by_priority list_for_con
      Console.print_list sorted
    end

   default_task :all 

  end


end
