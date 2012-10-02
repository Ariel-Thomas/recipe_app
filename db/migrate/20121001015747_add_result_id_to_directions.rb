class AddResultIdToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :result_id, :integer
  end
end
