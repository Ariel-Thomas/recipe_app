class Result < Ingredient
  attr_accessible :direction

  has_one :direction

  validates :direction, presence: true
end