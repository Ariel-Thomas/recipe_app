module RecipesHelper
  private

  def parse_ingredients
    if (params.include?(:id))
      recipe = Recipe.find(params[:id])

      params[:recipe][:ingredient_entries] = Recipe.parse_and_find_ingredients(params[:recipe][:ingredients_text], recipe)

      recipe.results_array.each do |result|
        #if (result.ingredient.direction.ingredient_entries.length != 0)

          params[:recipe][:ingredient_entries] << result
        #end
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
      hash = { title: direction.title, text: direction.text, direction: direction, width: direction.ingredient_entries.length,  depth: 1 }

      #left most ingredient block
      direction.results_array.each do |entry|
        result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        if (result[:depth] >= hash[:depth])
          hash[:depth] = result[:depth] + 1
        end

        hash[:width] += result[:width] - 1
      end

      direction.ingredients_array.each do |entry|
        directions_layout[0] << entry.to_s

        (hash[:depth] - 1).times do |index|
          directions_layout[index + 1] << { title: "", width: 1,  depth: index + 1 }
        end
      end


      unless (directions_layout[hash[:depth]])
        directions_layout << []
      end

      direction.results_array.each do |entry|
        result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        (hash[:depth] - result[:depth] - 1).times do |index|
          directions_layout[result[:depth] + index + 1] << { title: "", width: result[:width],  depth: result[:depth] + index + 1 }
        end
      end

      directions_layout[ hash[:depth] ] << hash
    end

    return directions_layout
  end

end
