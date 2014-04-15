class Game < ActiveRecord::Base
  has_many :teams
  has_many :role_ratings

  validates :name, presence: true
end
