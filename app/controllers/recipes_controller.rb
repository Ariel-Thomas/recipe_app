class RecipesController < ApplicationController

  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      flash[:success] = "Recipe created!" 
      redirect_to @recipe
    else
      render 'new'
    end

  end

  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe  = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "Recipe edited!" 
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted!"
    redirect_to recipes_path
  end
end
