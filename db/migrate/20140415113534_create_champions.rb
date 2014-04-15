class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer :game_id
      t.string :name

      t.timestamps
    end
  end
end
