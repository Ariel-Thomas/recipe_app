class AddTitleToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :title, :string 
  end
end
