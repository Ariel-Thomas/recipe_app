module IngredientParser
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
end