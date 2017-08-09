module AskewClient
  class ListManager

    def self.get_list
      list = Askew::TaskList.new Startup.config.todo_file
    end

    def self.get_sorted_tasklist
      list = Askew::TaskList.new Startup.config.todo_file
      sorted = Askew::TaskList.new(self.sort_tasklist_by_priority list)
    end

    def self.sort_tasklist_by_priority tasklist
      sorted_array = tasklist.sort_by {|key, value| [value.priority ? 0 : 1, value.priority || 0]} # list by priorty with nulls at the end
      sorted_hash = {}
      sorted_array.each {|subarray| sorted_hash[subarray[0]] = subarray[1]}
      Askew::TaskList.new(sorted_hash)
    end

  end
end
