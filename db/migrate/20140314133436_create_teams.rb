class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :year
      t.string :location

      t.timestamps
    end
  end
end
