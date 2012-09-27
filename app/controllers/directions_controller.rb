class DirectionsController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])

    if (params[:direction][:ingredient_entries] != nil)
      params[:direction][:ingredient_entries] = fix_ingredient_entries(params[:direction][:ingredient_entries])
    end

    @direction = @recipe.directions.create(params[:direction])

    if @direction.save
      flash[:success] = "Direction Added"

      @direction = @recipe.directions.new
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
      @state = { create: true }
    else  
      flash[:success] = "Direction Failed"
      @state = { create: false }
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
    end
  end

  def update
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.directions.find(params[:id]).destroy

    @direction = @recipe.directions.new()
    @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
    flash[:success] = "Direction deleted!"
  end

private
  def fix_ingredient_entries(ingredient_entries)
    ingredient_entries.values.map! do |entry_id|
      IngredientEntry.find(entry_id)
    end
  end
end
