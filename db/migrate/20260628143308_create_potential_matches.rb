class CreatePotentialMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :potential_matches do |t|
      t.references :user_1, null: false, foreign_key: { to_table: :users }
      t.references :user_2, null: false, foreign_key: { to_table: :users }

      t.string :state, null: false, default: "potential"

      t.references :match, null: true, foreign_key: true

      t.timestamps
    end

    add_index :potential_matches, [:user_1_id, :user_2_id], unique: true
  end
end