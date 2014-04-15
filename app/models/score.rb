class Score < ActiveRecord::Base
  has_many :champ_ratings

  validates :description, presence: true

  # muokkaa alla rajoja, jos skaala vaihtuu
  validates :value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }
end
