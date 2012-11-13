class Direction < ActiveRecord::Base
  attr_accessible :text, :ingredient_entries, :title

  validates :title, presence: true
  validates :text, presence: true
  validates :ingredient_entries, presence: true

  belongs_to :recipe
  has_many :ingredient_entries

  #result
  has_one :result, dependent: :destroy

  def self.direction_ingredient_array(directions)
    result = []

    directions.each do |direction|
      result << Array(direction.ingredient_entries)
    end

    result
  end

  def results_array
    Array(ingredient_entries.reject{ |entry| entry.ingredient.nil? || entry.ingredient.type != 'Result' })
  end

  def ingredients_array
    Array(ingredient_entries.reject{ |entry| entry.ingredient.nil? || entry.ingredient.type == 'Result' })
  end

  def has_ingredient(ingredient)
    ingredients_array.include?(ingredient)
  end
end
