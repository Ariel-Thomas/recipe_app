class IngredientEntry < ActiveRecord::Base
  attr_accessible :amount, :recipe, :ingredient
  delegate :name, to: :ingredient

  validates :amount, presence: true

  belongs_to :recipe
  belongs_to :direction
  belongs_to :ingredient
  
  def to_s
    amount + " " + ingredient.to_s
  end
end
