class DirectionsController < ApplicationController
  before_filter :fix_ingredient_entries, only: [:create, :update]
  before_filter :get_recipe_and_ingredients

  def create
    @direction = @recipe.directions.create(params[:direction])

    if @direction.save
      flash[:success] = "Direction Added"
      @recipe.add_result_for @direction
      redirect_to action: 'new'
    else  
      rerender_current_page  
    end
  end

  def new
    @direction = @recipe.directions.new
    rerender_current_page
  end

  def update_attributes
    rerender_current_page
  end

  def destroy
    direction = @recipe.directions.find(params[:id])
    #@recipe.get_result_from_ingredient_entries(direction).destroy
    direction.destroy

    flash[:success] = "Direction deleted!"
    redirect_to action: 'new'
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

    def get_recipe_and_ingredients
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction.present? }
    end
end
