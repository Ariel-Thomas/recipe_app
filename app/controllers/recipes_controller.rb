class RecipesController < ApplicationController
  before_filter :parse_ingredients, only: [:create, :update]

  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      flash[:success] = "Recipe created!"
      set_state_for :successful_recipe_creation 
    else
      set_state_for :unsuccessful_recipe_creation
    end
  end

  def new
    @recipe = Recipe.new
    set_state_for :new_recipe
  end

  def index
    @recipes = Recipe.search{ keywords(params[:search]) }  
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

    def set_state_for(state)
      case state
        when :successful_recipe_creation, :successful_recipe_update   
          @direction = @recipe.directions.new()
          @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction != nil }
          @state = { current_form: "recipe_directions_form" }
        when :unsuccessful_recipe_creation, :unsuccessful_recipe_update, :new_recipe, :editing_recipe    
          @state = { current_form: "recipe_form" }
      end
    end

    def make_directions_layout(recipe)
      directions_layout = [[],[]]

      recipe.directions.each do |direction|
        hash = { title: direction.title, direction: direction, height: direction.ingredient_entries.length + 1,  depth: 1 }

        #left most ingredient block
        direction.ingredient_entries.each do |entry|
          if entry.ingredient.type == 'Result'
            result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first

            hash[:depth] = result[:depth] + 1
            hash[:height] += result[:height] - 1

          else
            directions_layout[0] << entry.to_s
          end
        end

        directions_layout[0] << "___________"

        if (directions_layout[hash[:depth]] == nil)
          directions_layout << []
        end

        directions_layout[ hash[:depth] ] << hash
      end

      return directions_layout
    end
end
