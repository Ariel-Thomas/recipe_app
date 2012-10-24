module RecipesHelper
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
        @direction = @recipe.directions.new
        @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction.present? }
        @state = { current_form: "recipe_directions_form" }
      when :unsuccessful_recipe_creation, :unsuccessful_recipe_update, :new_recipe, :editing_recipe    
        @state = { current_form: "recipe_form" }
    end
  end

  def make_directions_layout(recipe)
    directions_layout = [[],[]]

    recipe.directions.each do |direction|
      hash = { title: direction.title, direction: direction, top: -1, height: direction.ingredient_entries.length,  depth: 1 }

      #left most ingredient block
      direction.ingredient_entries.each do |entry|
        if entry.ingredient.type == 'Result'
          result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first
          if (result[:depth] >= hash[:depth])
            hash[:depth] = result[:depth] + 1
          end

          if (result[:top] < hash[:top] || hash[:top] == -1 )
            hash[:top] = result[:top]
          end

          hash[:height] += result[:height] - 1

        else
          directions_layout[0] << entry.to_s
        end
      end

      unless (directions_layout[hash[:depth]])
        directions_layout << []
      end

      if (hash[:top] == -1)
        result = directions_layout[1].last

        if (result)
          hash[:top] = result[:top] + result[:height]
        else
          hash[:top] = 0
        end
      end

      directions_layout[ hash[:depth] ] << hash
    end

    return directions_layout
  end

end
