class IngredientEntry < ActiveRecord::Base
  attr_accessible :amount, :recipe, :ingredient

  belongs_to :recipe
  belongs_to :ingredient
end
