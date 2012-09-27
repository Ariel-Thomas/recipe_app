FactoryGirl.define do
  factory :ingredient_entry do
    sequence(:amount) { |n| "Amount #{n}"}

    ingredient
  end

  factory :ingredient do
    sequence(:name) { |n| "Ingredient #{n}"}
  end

  factory :direction do
    sequence(:text) { |n| "Direction #{n}"}
  end

  factory :recipe do
    sequence(:name)   { |n| "Recipe #{n}" }
    description "A description"
  #  ingredient_entries FactoryGirl.create(:ingredient_entry)
  end
end