class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.text :text

      t.timestamps
    end
  end
end
