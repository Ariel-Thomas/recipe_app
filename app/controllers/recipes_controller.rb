class RecipesController < ApplicationController

  def create

    @recipe = Recipe.new(name: params[:recipe][:name],
      description: params[:recipe][:description],
      ingredient_entries: parse_ingredients(params[:recipe][:ingredients]))

    if @recipe.save
      flash[:success] = "Recipe created!" 
      flash[:debug] = @recipe.ingredients_array
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
    
    #@recipes = Recipe.all if !@recipes
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


  def parse_ingredients(text)
    # match all line ends bounded by words, but not the last one

    text.gsub(/\s*$/,'').split(/$[^\z]/).map! do |entry|
      amount = entry.slice!(/^\d+ \w+ /).chop()
      ingredient = Ingredient.create!(name: entry)

      IngredientEntry.create!( amount: amount, ingredient: ingredient )
    end
  end

end
