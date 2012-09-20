class Recipe < ActiveRecord::Base
  attr_accessible :name, :description, :ingredients

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true

  searchable do
    text :name, :description
    text :ingredients 
  end

  def ingredients_array
     ingredients.split('\n')
  end

end
