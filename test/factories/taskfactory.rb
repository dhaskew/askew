FactoryGirl.define do

  factory :task, class: Askew::Task, aliases: [:simple_task] do
    text "test task text"

    initialize_with { new(text) }
  end

  factory :prioritized_task, class: Askew::Task, aliases: [:simple_prioritized_task] do
    priority { ('A'..'Z').to_a.sample }
    text { "(#{priority}) test task text" }
    
    initialize_with { new(text) }
  end

end
