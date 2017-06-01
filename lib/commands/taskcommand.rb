require_relative 'tasklistcommand.rb'

module Askew

  class TaskCommand < CommandBase 

    desc "list", "List tasks/projects/contexts"
    subcommand "list", Askew::TaskListCommand

    desc "nav TASK_#", "Navigate to link tags"
    def nav task_num
      puts "No support for #{RUBY_PLATFORM}" if OS.windows?
      list = ListManager.get_list
      list[task_num.to_i].tags.each do |key,value|
        next if !key.match(/^link/)
        result = `#{OS.open_file_command} '#{value}'`
        puts "Link must begin with http or https" if OS.mac? && !value.match(/^http/)
      end
    end

    desc "archive", "Archive all done tasks"
    def archive
      list = ListManager.get_list
      list.archive_done
      list.remove_done
      list.save!
    end

    desc "do TASK_#", "Mark TASK_# as done."
    def do task_num 
      list = ListManager.get_list
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
      list = ListManager.get_list

      if !list[task_num.to_i].done?
        puts "Item #{task_num} is not yet completed. No change made."
        return
      end

      list[task_num.to_i].undo!
      puts "Item #{task_num} has been marked incomplete #{list[task_num.to_i].raw}"
      list.save!
    end

    desc "tag TASK_# NEW_TAGS", "Replace existing tags for TASK_# with NEW_TAGS"
    def tag task_num, *tags
      list = ListManager.get_list
      new_tags = {}
      tags.each do |kvpair|
        pair = kvpair.split(':')
        new_key = pair[0] #first colon is the tag key
        new_value = pair[1..-1].join(':') #rejoin incase the value had a colon in it.
        new_tags[new_key] = new_value
      end
      list[task_num.to_i].tags = new_tags
      list.save!
    end

    desc "con TASK_# NEW_CONTEXTS", "Replace existing contexts for TASK_# with NEW_CONTEXTS"
    def con task_num, *cons
      list = ListManager.get_list
      list[task_num.to_i].contexts = cons
      list.save!
    end

    desc "proj TASK_# NEW_PROJECTS", "Replace existing projects for TASK_# with NEW_PROJECTS"
    def proj task_num, *projs
      list = ListManager.get_list
      list[task_num.to_i].projects = projs
      list.save!
    end

    desc "inpri TASK_#", "Increase priority of TASK_# by one degree"
    def inpri task_num
      list = ListManager.get_list
      task = list[task_num.to_i]

      if task.priority == "A"
        puts "Task already set to highest priority 'A'"
        return
      end

      letters = ('B'..'Z').to_a
      if letters.include? task.priority
        list[task_num.to_i].priority = letters[(letters.index task.priority) - 1] # B becomes A, C becomes B, etc
        list.save!
      end

    end

    desc "depri TASK_#", "Deprioritize TASK_# by one degree"
    def depri task_num
      list = ListManager.get_list
      task = list[task_num.to_i]

      if task.priority == "Z"
        puts "Task already set to lowest priority 'Z'"
        return
      end

      letters = ('A'..'Z').to_a
      if letters.include? task.priority
        list[task_num.to_i].priority = letters[(letters.index task.priority) + 1] # A becomes B, C becomes D, etc
        list.save!
      end
    end

    desc "pri | priority TASK_# NEW_PRIORITY", "Update TASK_# with NEW_PRIORITY"
    def pri task_num, pri=nil
      list = ListManager.get_list
      list[task_num.to_i].priority = pri
      list.save!
    end

    desc "txt TASK_# NEW_TEXT", "Update TASK_# with NEW_TEXT"
    def txt task_num, *text
      list = ListManager.get_list
      list[task_num.to_i].text = text.join ' '
      list.save!
    end

    #map priority: :pri

    desc "add TASK_INFO", "Add a task"
    def add *task_text
      new_task = Askew::Task.new task_text.join ' '
      list = ListManager.get_list
      list[list.count + 1] = new_task
      list.save!
    end

    map rm: :remove
    
    desc "remove | rm TASK_#", "Remove a task"
    def remove num
      list = ListManager.get_list
      index_to_rm = num.to_i
      if yes? "[y,yes] Ok to remove task #{num}? : #{list[index_to_rm].raw}"
        list.delete(index_to_rm)
        list.save!
      end
    end

    desc "show TASK_#", "Show all the details of a task"
    def show num
      Console.show_task num 
    end

    default_task :list

  end

end
