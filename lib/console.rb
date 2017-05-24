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

    def self.print_list task_list=nil
      return if task_list == nil
      
      ids = []
      #collect only the line #'s
      task_list.flatten.each_with_index {|item,index| ids << item if index.even?} 
      #find the char count of the biggest line # 
      max = ids.max.to_s.size

      puts ""
      puts "#{'#'*max} Pri Project  Context    Task"
      puts "-"*150

      temp_list = ListManager.get_list
      projects = temp_list.projects
      contexts = temp_list.contexts 

      task_list.each do |key,value|

        num = "#{key.to_s.rjust(max,' ')}" 

        pri = "   "
        pri = "(#{value.priority})" if value.priority != nil

        proj = value.projects.count == 1 ? value.projects[0] : "Multiple"
        proj =  proj.ljust(8, ' ')

        con = value.contexts.count == 1 ? value.contexts[0] : "Multiple"
        con = con.ljust(8, ' ')

        txt = value.text[0..70]
        txt = txt.ljust(70, ' ')

        tags = ""

        truncate = "[...]"


        value.tags.each {|key,value| tags = tags + key.to_s + ":" + value }

        tags = tags[0..50] + " " + truncate if tags.size > 50

        line = "#{num} #{pri} #{proj} #{con}   #{txt} #{tags}"

        puts line

      end

      footer = "-"*150
      puts footer
      footer = "Task Count: #{task_list.count} | Projects: #{projects.join(' , ')} | Contexts: #{contexts.join(' , ')}"
      puts footer
      puts ""
    end

  end

end
