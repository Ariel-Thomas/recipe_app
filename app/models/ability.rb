class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can [:new, :create], User

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