class AddRecipeIdAndIngredientIdToRecipeEntry < ActiveRecord::Migration
  def change
    add_column :ingredient_entries, :ingredient_id, :integer
    add_column :ingredient_entries, :recipe_id, :integer
  end
end
