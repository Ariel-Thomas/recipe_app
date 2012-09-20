class Ingredient < ActiveRecord::Base
  attr_accessible :name, :ingredient_entries

  has_many :ingredient_entries
end
