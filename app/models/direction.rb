class Direction < ActiveRecord::Base
  attr_accessible :text, :ingredient_entries

  validates :text, presence: true
  validates :ingredient_entries, presence: true

  belongs_to :recipe
  has_many :ingredient_entries

end
