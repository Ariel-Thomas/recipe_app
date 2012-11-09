class DirectionsController < ApplicationController
  include State
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

    rerender_current_page
  end

  def update_attributes
    rerender_current_page
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    direction = @recipe.directions.find(params[:id])
    #@recipe.get_result_from_ingredient_entries(direction).destroy
    direction.destroy

    set_state_for :direction_deletion
    flash[:success] = "Direction deleted!"

    rerender_current_page
  end

  private

    def fix_ingredient_entries
      if (params[:direction][:ingredient_entries].present?)
        params[:direction][:ingredient_entries] =
          params[:direction][:ingredient_entries].values.map! { |entry_id| IngredientEntry.find(entry_id) }
      end
    end

    def rerender_current_page
      render 'recipes/' + session[:cur_page], formats: [:html]
    end
end
