class Ingredient < ActiveRecord::Base
  attr_accessible :name, :ingredient_entries
  
  validates :name, presence: true

  has_many :ingredient_entries, dependent: :destroy


  def to_s
    name
  end
end
