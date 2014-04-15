class RoleRating < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
  belongs_to :game
  belongs_to :score

  validates :role_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :score_id, presence: true, numericality: { only_integer: true }
  validates :game_id, presence: true, numericality: { only_integer: true }
end
