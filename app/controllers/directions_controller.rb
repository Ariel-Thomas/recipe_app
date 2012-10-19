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
  end

  def update
    render 'create', formats: [:js]
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.directions.find(params[:id]).destroy

    set_state_for :direction_deletion

    flash[:success] = "Direction deleted!"

    render 'create', formats: [:js]
  end
end
