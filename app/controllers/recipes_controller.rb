class RecipesController < ApplicationController
  include RecipesHelper
  before_filter :parse_ingredients, only: [:create, :update]

  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      flash[:success] = "Recipe created!"
      set_state_for :successful_recipe_creation 
    else
      set_state_for :unsuccessful_recipe_creation
    end
     
    render 'new', formats: [:html]
  end

  def new
    @recipe = Recipe.new
    set_state_for :new_recipe
  end

  def index
    @recipes = Recipe.search do
      keywords params[:search]
      paginate :per_page => 10, :page => params[:page] || 1
    end.results
  end

  def show
    @recipe = Recipe.find(params[:id])

    @directions_layout = make_directions_layout(@recipe)
  end

  def update
    @recipe  = Recipe.find(params[:id]) 

    if @recipe.update_attributes(params[:recipe])
      flash[:success] = "Recipe edited!"
      set_state_for :successful_recipe_update 
    else
      set_state_for :unsuccessful_recipe_update
    end

    render 'edit', formats: [:html]
  end

  def edit
    @recipe = Recipe.find(params[:id])
    set_state_for :editing_recipe
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted!"
    
    redirect_to recipes_path
  end
end
