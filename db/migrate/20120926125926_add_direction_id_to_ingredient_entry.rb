class AddDirectionIdToIngredientEntry < ActiveRecord::Migration
  def change
    add_column :ingredient_entries, :direction_id, :integer
  end
end
