module Askew
  class Console
    def self.show_task num
      list = ListManager.get_list
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

    def self.print_tasklist task_list=nil
      return if task_list == nil
      return if !task_list.instance_of? TaskList

      max = task_list.keys.max.to_s.size

      task_column_size = 70

      puts ""
      puts "#{'#'*max} Pri Project  Context    #{'Task'.ljust(task_column_size,' ')} Tags"
      puts "-"*150

      projects = task_list.projects
      contexts = task_list.contexts

      task_list.each do |key,value|

        num = "#{key.to_s.rjust(max,' ')}"

        pri = "   "
        pri = "(#{value.priority})" if value.priority != nil

        proj = value.projects.count == 1 ? value.projects[0] : "Multiple"
        proj =  proj.ljust(8, ' ')

        con = value.contexts.count == 1 ? value.contexts[0] : "Multiple"
        con = "" if !value.contexts.any?
        con = con.ljust(8, ' ')
        
        truncate = "[...]"

        txt = value.text[0..63]
        txt = txt + " " + truncate if value.text.size > 65
        txt = txt.ljust(task_column_size, ' ')

        tags = ""

        value.tags.each {|key,value| tags = tags + key.to_s + ":" + value }

        tags = tags[0..50] + " " + truncate if tags.size > 50

        line = "#{num} #{pri} #{proj} #{con}   #{txt} #{tags}"

        line = line.red.bold if value.done?

        puts line

      end

      footer = "-"*150
      puts footer
      footer = "Task Count: #{task_list.count} | Projects: #{projects.join(' , ')} | Contexts: #{contexts.size > 0 ? contexts.join(' , ') : "None" }"
      puts footer
      puts ""
    end
  end #end class
end #end module
