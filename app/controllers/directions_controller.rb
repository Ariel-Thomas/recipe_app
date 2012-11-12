class DirectionsController < ApplicationController
  before_filter :fix_ingredient_entries, only: [:create, :update]

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @direction = @recipe.directions.new
    @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction.present? }
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @direction = @recipe.directions.create(params[:direction])

    if @direction.save
      flash[:success] = "Direction Added"
      @recipe.add_result_for @direction
    else
      flash[:alert] = "Error while adding direction"
    end

    redirect_to recipe_directions_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    direction = @recipe.directions.find(params[:id])
    direction.destroy
    flash[:success] = "Direction deleted!"
    redirect_to recipe_directions_path(@recipe)
  end

  private

    def fix_ingredient_entries
      if (params[:direction][:ingredient_entries].present?)
        params[:direction][:ingredient_entries] =
          params[:direction][:ingredient_entries].values.map! { |entry_id| IngredientEntry.find(entry_id) }
      end
    end
end
