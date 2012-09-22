FactoryGirl.define do
  factory :recipe do
    sequence(:name)   { |n| "Recipe #{n}" }
    description "A description" 
  end
end