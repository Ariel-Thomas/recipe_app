class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    #Guests can see all content and sign up
    can :read, :all
    can [:new, :create], User

    #Admin can manage everything
    can :manage, :all do 
      user.admin?
    end

    #Users can manage their pages
    can [:update, :destroy], User do |target_user|
      target_user == user
    end

    can [:new, :create], Recipe
    can :manage, Recipe do |recipe|
      recipe.try(:user) == user
    end
    
    can [:new, :create], Direction
    can :manage, Direction do |direction|
      direction.try(:recipe).try(:user) == user
    end
  end
end