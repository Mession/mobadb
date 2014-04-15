class CreateChampRatings < ActiveRecord::Migration
  def change
    create_table :champ_ratings do |t|
      t.integer :user_id
      t.integer :champion_id
      t.integer :score_id
      t.text :comment

      t.timestamps
    end
  end
end
