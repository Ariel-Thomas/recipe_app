class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :email, :password, :password_confirmation, :admin, :avatar_url

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email

  has_many :recipes
  has_many :favorites
end
