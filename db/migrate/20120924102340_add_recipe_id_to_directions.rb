class AddRecipeIdToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :recipe_id, :integer
  end
end
