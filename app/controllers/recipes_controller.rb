class RecipesController < ApplicationController

  def create
    @recipe = Recipe.new(name: params[:recipe][:name],
      description: params[:recipe][:description])

    ingredient_entries = Recipe.parse_and_create_ingredients(params[:recipe][:ingredients_text])

    @recipe.ingredient_entries = ingredient_entries

    if @recipe.save
      flash[:success] = "Recipe created!" 
      flash[:debug] = params[:recipe][:ingredients_text]
      redirect_to @recipe
    else
      render 'new'
    end

  end

  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.search{ keywords(params[:search]) }    
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe  = Recipe.find(params[:id])

    ingredient_entries = Recipe.parse_and_create_ingredients(params[:recipe][:ingredients_text])

    if @recipe.update_attributes(name: params[:recipe][:name],
      description: params[:recipe][:description],      ingredient_entries: ingredient_entries)
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

  private
    def good_ingredients?(ingredients_entries, error_saver)
      if (ingredients_entries == [])
        error_saver[:ingredients] = " field must not be left blank"
        return false
      end

      if (ingredients_entries == nil)
        error_saver[:ingredients] = " field must be formated amount measurement ingredient_name"
        return false
      end

      return true
    end
end
