class RecipesController < ApplicationController

  def create
    @recipe = Recipe.new(name: params[:recipe][:name],
      description: params[:recipe][:description])

    @recipe.ingredient_entries = Recipe.parse_and_create_ingredients(params[:recipe][:ingredients_text])

    if @recipe.save
      flash[:success] = "Recipe created!"

      @direction = @recipe.directions.new()
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
      @state = { current_form: "recipe_directions_form" } 
    else
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
      @state = { current_form: "recipe_form" }
    end

  end

  def new
    @recipe = Recipe.new
    @state = { current_form: "recipe_form" }
  end

  def index
    @recipes = Recipe.search{ keywords(params[:search]) }    
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe  = Recipe.find(params[:id]) 

    if @recipe.update_attributes(name: params[:recipe][:name],
      description: params[:recipe][:description],      ingredient_entries: Recipe.parse_and_find_ingredients(params[:recipe][:ingredients_text], @recipe))

      flash[:success] = "Recipe edited!" 

      @direction = @recipe.directions.new()
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
      @state = { current_form: "recipe_directions_form" } 
    else
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
      @state = { current_form: "recipe_form" }
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @state = { current_form: "recipe_form" }
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
