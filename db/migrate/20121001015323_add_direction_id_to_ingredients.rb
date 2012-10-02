class AddDirectionIdToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :direction_id, :integer
  end
end
