class RecipesController < ApplicationController
  before_filter :parse_ingredients, only: [:create, :update]

  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      flash[:success] = "Recipe created!"
      redirect_to recipe_directions_path(@recipe)
    else
      flash.now[:alert] = "Error while creating recipe"
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def index
    @recipes = Recipe.search_for(params[:search]).paginate(:page => params[:page] || 1, :per_page => 10)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe  = Recipe.find(params[:id]) 

    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "Recipe updated!"
      redirect_to recipe_directions_path(@recipe)
    else
      flash.now[:alert] = "Error while updating recipe"
      render :edit
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

    def parse_ingredients
      if (params.include?(:id))
        recipe = Recipe.find(params[:id])

        params[:recipe][:ingredient_entries] = Recipe.parse_and_find_ingredients(params[:recipe][:ingredients_text], recipe)

        recipe.results_array.each do |result|
          params[:recipe][:ingredient_entries] << result
        end

      else
        params[:recipe][:ingredient_entries] = Recipe.parse_and_create_ingredients(params[:recipe][:ingredients_text])
      end

      params[:recipe].delete(:ingredients_text)
    end
end
