FactoryGirl.define do
  factory :muscle_target do
    primary false
    exercise
    muscle_group
  end

  factory :primary_target, class: MuscleTarget do
    primary true
    exercise
    association :muscle_group, factory: :muscle_group, name: "Glutes"
  end
end
