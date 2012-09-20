class Recipe < ActiveRecord::Base
  attr_accessible :name, :description, :ingredient_entries, :ingredients

  has_many :ingredient_entries, dependent: :destroy
  accepts_nested_attributes_for :ingredient_entries, :allow_destroy => true
  has_many :ingredients, through: :ingredient_entries
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true
  validates :description, presence: true

  searchable do
    text :name, :description
    text :ingredients 
  end

  def ingredients_array
    ingredient_entries.map { |entry| entry.amount + " " + entry.ingredient.name }
  end


end
