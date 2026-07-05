class AddPositionToPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :photos, :position, :integer, null: false, default: 0

    add_index :photos, [:user_id, :position], unique: true
  end
end
