FactoryGirl.define do
  factory :exercise do
    name "Squats"
    description "Bend your knees till it hurts"
    sets 2
    reps 10
  end

  factory :cardio_exercise, class: "Exercises::CardioExercise" do
    name "Rowing"
    description "Find an expensive rowing machine and pull"
    duration 300
    type "Exercises::CardioExercise"
  end
end
