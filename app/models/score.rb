class Score < ActiveRecord::Base
  has_many :champ_ratings, dependent: :destroy
  has_many :role_ratings, dependent: :destroy

  validates :description, presence: true

  # muokkaa alla rajoja, jos skaala vaihtuu
  validates :value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }


  # viimehetkella keksitty hassu pikku lisa arvojen visualisointiin
  def color_hex_code
  	if self.value == 5
  		return "#FF0000"
  	elsif self.value == 4
  		return "#FF8000"
  	elsif self.value == 3
  		return "#FFF000"
  	elsif self.value == 2
  		return "#80FF00"
  	elsif self.value == 1
  		return "#10FF00"
  	end
  	return ""
  end

end
