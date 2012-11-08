module DirectionsHelper
  private
  
  def fix_ingredient_entries
    if (params[:direction][:ingredient_entries].present?)
      params[:direction][:ingredient_entries] =
        params[:direction][:ingredient_entries].values.map! { |entry_id| IngredientEntry.find(entry_id) }
    end
  end

  def set_state_for(state)
    case state
    when :successful_direction_creation,:direction_deletion
      @direction = @recipe.directions.new
      @state = { current_form:  "recipe_directions_form", create_direction: true }
    when :unsuccessful_direction_creation
      @state = { current_form:  "recipe_directions_form", create_direction: false }
    end

    @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction.present? }
  end

  def rerender_current_page
    render 'recipes/' + session[:cur_page], formats: [:html]
  end
end
