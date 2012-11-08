module State
  private

  def set_state_for(state)
    case state
      when :successful_direction_creation,:direction_deletion, :successful_recipe_creation, :successful_recipe_update 
        @direction = @recipe.directions.new
        @state = { current_form:  "recipe_directions_form", show_directions_form: false }
      
      when :unsuccessful_direction_creation
        @state = { current_form:  "recipe_directions_form", show_directions_form: true }

      when :unsuccessful_recipe_creation, :unsuccessful_recipe_update, :new_recipe, :editing_recipe   
        @state = { current_form: "recipe_form", show_directions_form: false  }
    end

    begin
      @ingredient_entries = @recipe.ingredient_entries.reject { |entry| entry.direction.present? }
    rescue
      @ingredinet_entries = nil
    end

  end


end