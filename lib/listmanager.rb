module Askew
  class ListManager
    
    def self.get_list
      list = Askew::TaskList.new Startup.config.todo_file 
    end 
    
    def self.get_sorted_list
      list = ListManager.get_list
      sorted = list.sort_by {|key, value| [value.priority ? 0 : 1, value.priority || 0]} # list by priorty with nulls at the end
    end 

  end
end
