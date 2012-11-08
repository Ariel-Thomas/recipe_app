class DirectionsController < ApplicationController
  include DirectionsHelper
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

    render 'recipes/edit', formats: [:html]
  end

  def update
    render 'recipes/edit', formats: [:html]
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    direction = @recipe.directions.find(params[:id])

    #@recipe.get_result_from_ingredient_entries(direction).destroy
    direction.destroy

    set_state_for :direction_deletion

    flash[:success] = "Direction deleted!"

    render 'recipes/edit', formats: [:html]
  end
end
