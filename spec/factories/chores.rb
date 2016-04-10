FactoryGirl.define do
  factory :chore do
    sequence(:name) { |n| "Chore #{n}" }
    category
    description nil
    completed false
  end
end
