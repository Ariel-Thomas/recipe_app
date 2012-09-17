class RecipesController < ApplicationController

  def create
    @recipe = Recipe.new(params[:user])
    if @recipe.save
      flash[:success] = "Recipe created!"
      render 'new'
    else 
      render 'new'
    end
  end

  def new
    @recipe = Recipe.new
  end
end
