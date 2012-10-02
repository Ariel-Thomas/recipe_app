class DirectionsController < ApplicationController
  before_filter :fix_ingredient_entries, only: [:create, :update]


  def create
    @recipe = Recipe.find(params[:recipe_id])
    @direction = @recipe.directions.create(params[:direction])

    if @direction.save
      flash[:success] = "Direction Added"

      @recipe.add_result_for @direction
      set_state_for :successful_direction_creation
    else  
      set_state_for :unsuccessful_direction_creation  
    end
  end

  def update
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.directions.find(params[:id]).destroy

    set_state_for :direction_deletion

    flash[:success] = "Direction deleted!"
  end

private
  def fix_ingredient_entries
    if (!params[:direction][:ingredient_entries].nil?)
      params[:direction][:ingredient_entries] =
        params[:direction][:ingredient_entries].values.map! { |entry_id| IngredientEntry.find(entry_id) }
    end
  end

  def set_state_for(state)
    case state
    when :successful_direction_creation,:direction_deletion
      @direction = @recipe.directions.new
      @state = { create: true }
    when :unsuccessful_direction_creation
      @state = { create: false }
    end
     @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
  end
end
