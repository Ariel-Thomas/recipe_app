class Favorite < ActiveRecord::Base
  attr_accessible :recipe, :user

  belongs_to :user
  belongs_to :recipe
end