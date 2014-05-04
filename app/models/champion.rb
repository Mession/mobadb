class Champion < ActiveRecord::Base
  belongs_to :game

  validates :name, presence: true
  validates :game_id, presence: true, numericality: { only_integer: true }

  def wiki_link
  	if self.game.name == "League of Legends"
  		link = lol_wiki_address + name
  	elsif self.game.name == "Dota 2"
  		link = dota2_wiki_address + name
  	end
  	return link
  end

  private

	  def lol_wiki_address
		return "http://leagueoflegends.wikia.com/wiki/"end

	  def dota2_wiki_address
		return "http://dota2.gamepedia.com/"  	
	  end
end
