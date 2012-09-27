class IngredientEntry < ActiveRecord::Base
  attr_accessible :amount, :recipe, :ingredient

  validates :amount, presence: true

  belongs_to :recipe
  belongs_to :direciton
  belongs_to :ingredient
end
