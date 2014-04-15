class CreateRoleRatings < ActiveRecord::Migration
  def change
    create_table :role_ratings do |t|
      t.integer :role_id
      t.integer :user_id
      t.integer :score_id
      t.integer :game_id

      t.timestamps
    end
  end
end
