FactoryGirl.define do
    trait :random_priority do
      priority { ('A'..'Z').to_a.sample }
    end

    trait :created_today do
      created_on { Askew::Task.today_date_string }
    end

    factory :task, class: Askew::Task do
      created_on nil
      priority nil
      text nil
      contexts [ ]
      projects [ ]
      tags [ ]
      skip_create
      initialize_with {
                        priority_string = ""

                        if !priority.nil?
                          priority_string = "(" + priority + ")"
                        end
                        
                        task_string = [ priority_string,
                                        created_on, 
                                        text,
                                        contexts.join(" "),
                                        projects.join(" "),
                                        tags.join(" "),
                                      ].join(" ")
                        
                        new(task_string)
                      }
    end #end task factory
end #end factory girl block
