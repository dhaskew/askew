FactoryGirl.define do

    trait :random_text do
      text "test task text"
    end

    trait :random_priority do
      priority { ('A'..'Z').to_a.sample }
    end

    trait :no_priority do
      priority nil
    end

    factory :simple_task, class: Askew::Task do
      initialize_with { new(text) }
    end

    factory :prioritized_task, class: Askew::Task do #, parent: :task do
      initialize_with { new("(#{priority}) #{text}") }
    end
end
