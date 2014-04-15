class Champion < ActiveRecord::Base
  belongs_to :game

  validates :name, presence: true
  validates :game_id, presence: true, numericality: { only_integer: true }
end
