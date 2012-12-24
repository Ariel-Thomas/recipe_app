class User < ActiveRecord::Base
  #authenticates_with_sorcery!

  attr_accessible :username, :email, :password, :password_confirmation, :admin, :about_me, :avatar_url, :authentications_attributes

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :recipes
  has_many :favorites
  has_many :authentications, :dependent => :destroy
    
  accepts_nested_attributes_for :authentications
end
