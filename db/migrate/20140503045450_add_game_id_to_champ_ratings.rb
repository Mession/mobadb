class AddGameIdToChampRatings < ActiveRecord::Migration
  def change
    add_column :champ_ratings, :game_id, :integer
  end
end
