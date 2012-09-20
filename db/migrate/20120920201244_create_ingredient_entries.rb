class CreateIngredientEntries < ActiveRecord::Migration
  def change
    create_table :ingredient_entries do |t|
      t.string :amount

      t.timestamps
    end
  end
end
