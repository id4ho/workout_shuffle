FactoryGirl.define do
  factory :user do
    email "dude@example.com"
    password "password"
  end

  factory :admin, class: "User" do
    email "important_dude@example.com"
    password "password"
    admin true
  end
end
