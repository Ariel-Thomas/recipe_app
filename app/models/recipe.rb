class Recipe < ActiveRecord::Base
  attr_accessible :name, :description, :ingredient_entries, :ingredients

  has_many :ingredient_entries, dependent: :destroy
  accepts_nested_attributes_for :ingredient_entries, :allow_destroy => true
  has_many :ingredients, through: :ingredient_entries
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredient_entries, presence: true

  searchable do
    text :name, :description
    text :ingredients_name do
      ingredients.map { |ingredient| ingredient.name}
    end 
  end

  def ingredients_array
    ingredient_entries.map { |entry| entry.amount + " " + entry.ingredient.name }
  end

  def ingredients_text
    ingredients_array.join("\n")
  end

  def self.parse_and_create_ingredients(text)
    text.gsub(/(\A\s*$\n)|(\s*$)/,'').split(/$[^\z]/).map! do |entry|
      amount = entry.slice!(/^\d+ \w+ /)
      if (amount != nil) then amount.chop!() else return end

      IngredientEntry.create!( amount: amount, ingredient: Ingredient.create!(name: entry) )
    end
  end

  def self.valid_ingredients?(text)
    if text == nil
      return false
    end

    text.gsub(/(\A\s*$\n)|(\s*$)/,'').split(/$[^\z]/).map do |entry|
      
      amount = entry.slice!(/^\d+ \w+ /)
      if (amount == nil)
        return false
      end

      if (entry.length == 0)
        return false
      end
    end

    return true;
  end

end
