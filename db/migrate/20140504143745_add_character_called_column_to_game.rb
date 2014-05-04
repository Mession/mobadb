class AddCharacterCalledColumnToGame < ActiveRecord::Migration
  def change
  	add_column :games, :character_called, :string
  end
end
