class ChampRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :champion
  belongs_to :score
  has_one :game, through: :champion

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :champion_id, presence: true, numericality: { only_integer: true }
  validates :score_id, presence: true, numericality: { only_integer: true }
  validates :game, presence: true
end
