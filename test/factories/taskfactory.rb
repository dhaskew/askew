FactoryGirl.define do
    trait :random_priority do
      priority { ('A'..'Z').to_a.sample }
    end

    trait :created_today do
      created_on { Askew::Task.today_date_string }
    end

    factory :task, class: Askew::Task do
      transient do
        completion_marker false
        completed_on nil
        require_completed_on { Askew::Options.new.require_completed_on }
      end
      created_on nil
      priority nil
      text nil
      contexts [ ]
      projects [ ]
      tags [ ]
      skip_create
      initialize_with {
                        priority_string = priority.nil? ? "" : "(#{priority})"

                        marker = completion_marker ? Askew::PatternHelpers::COMPLETED_FLAG : ""

                        task_string = [ marker,
                                        priority_string,
                                        completed_on,
                                        created_on,
                                        text,
                                        contexts.join(" "),
                                        projects.join(" "),
                                        tags.join(" "),
                                      ].join(" ")

                        options = Askew::Options.new

                        options.require_completed_on = require_completed_on

                        new(task_string, options)
                      }
    end #end task factory
end #end factory girl block
