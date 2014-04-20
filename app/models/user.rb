class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }, length: { maximum: 15 }

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :role_ratings, dependent: :destroy
  has_many :roles, through: :role_ratings
  has_many :champ_ratings, dependent: :destroy

  def is_leader_of_any_team
  	memberships = self.memberships

  	memberships.each do |m|
  		return true if m.team_leader
  	end
  	return false
  end

  def is_leader_of(given_team)
  	memberships = self.memberships

  	memberships.each do |m|
  		if m.team == given_team and m.team_leader
  			return true
  		end
  	end
  	return false
  end

  def owned_teams
  	memberships = self.memberships
  	teams_array = Array.new

  	memberships.each do |m|
  		teams_array.push m.team if m.team_leader
  	end
  	return teams_array
  end

end
