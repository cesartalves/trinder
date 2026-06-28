class AddLikedByToPotentialMatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :potential_matches,
                  :liked_by,
                  foreign_key: { to_table: :users },
                  null: true
  end
end