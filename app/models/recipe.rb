class Recipe < ActiveRecord::Base
  before_save :update_author

  attr_accessible :name, :description, :ingredient_entries, :ingredients, :user, :user_id, :author

  belongs_to :user
  has_many :ingredient_entries, dependent: :destroy
  accepts_nested_attributes_for :ingredient_entries, :allow_destroy => true
  has_many :ingredients, through: :ingredient_entries
  accepts_nested_attributes_for :ingredients
  has_many :directions, dependent: :destroy
  accepts_nested_attributes_for :directions, :allow_destroy => true

  validates :name, presence: true
  validates :description, presence: true
  validates :ingredient_entries, presence: true

  scoped_search on: [:name, :description, :author]

  def ingredients_text
    ingredient_entries.reject{ |entry| entry.ingredient.nil? ||entry.ingredient.type == 'Result' }.join("\n")
  end

  def results_array
    Array(ingredient_entries.reject{ |entry| entry.ingredient.nil? ||entry.ingredient.type != 'Result' })
  end

  def add_result_for(direction)
    ingredient_entries.create!(amount: "1 whole",
      ingredient: direction.result = Result.create!(name: "results from " + direction.title, direction: direction))
  end

  def get_result_from_ingredient_entries(direction)
    results_array.select{ |entry| entry.ingredient.direction == direction }.first
  end

  def self.parse_and_create_ingredients(text)
    text.gsub(/(\A\s*$\n)|(\s*$)/,'').split(/$[^\z]/).map! do |entry|
      amount = entry.slice!(/^\d+ \w+ /)
      if (amount.present?) then amount.chop!() else return end

      #handles calls from parse_and_find_ingredients
      block_given? && yield(amount, entry) ||

      IngredientEntry.create!( amount: amount, ingredient: Ingredient.find_or_create_by_name(name: entry) )
    end
  end

  def self.parse_and_find_ingredients(text, recipe)
    parse_and_create_ingredients(text) do |amount, entry|
      Array(recipe.ingredient_entries.find_all_by_amount(amount)).find{|sub_entry|sub_entry.ingredient.name == entry}
    end
  end

  private
    def update_author
      self.author = user.try(:username) || "unknown user"
    end
end
