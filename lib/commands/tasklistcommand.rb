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
        Console.print_tasklist ListManager.get_sorted_tasklist
      rescue Exception => e
        puts "Unable to load your todo list."
        puts e
      end
    end

    desc "search TERM", "List all tasks that contain TERM"
    def search term
      tasklist_for_search = ListManager.get_sorted_tasklist.search term
      Console.print_tasklist tasklist_for_search
    end

    desc "for_project X", "List all tasks connected to project X"
    def for_project proj
      tasklist_for_proj = ListManager.get_sorted_tasklist.by_project proj
      Console.print_tasklist tasklist_for_proj
    end

    desc "for_context X", "List all tasks connected to context X"
    def for_context con
      tasklist_for_con = ListManager.get_sorted_tasklist.by_context con
      Console.print_tasklist tasklist_for_con
    end

   default_task :all 

  end


end
