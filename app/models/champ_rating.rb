class ChampRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :champion
  belongs_to :score
  has_one :game, through: :champion

end
