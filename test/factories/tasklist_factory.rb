FactoryGirl.define do

  factory :tasklist, class: Askew::TaskList do
    transient do
      number_of_tasks 15
      tasks {{}}
    end

    skip_create
    initialize_with {
                      tasks_to_create = {}

                      if tasks.empty?
                        defaulttasks = { }

                        1.upto number_of_tasks do |i|
                          task = create :task, :text => "task text #{i}"
                          defaulttasks[i] = task
                        end

                        tasks_to_create = defaulttasks
                      else
                        tasks_to_create = tasks
                      end

                      new(tasks_to_create)
                    }
  end #end tasklist factory

end #end factorygirl block
