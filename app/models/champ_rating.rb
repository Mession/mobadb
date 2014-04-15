class ChampRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :champion
  belongs_to :score
  belongs_to :game, throught: :champion

end
