class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:team_id], :message => "cant be in the same team twice"
  validates :user_id, numericality: { only_integer: true }
  validates :team_id, numericality: { only_integer: true }
  validate :no_multiple_leaders
  validate :no_more_members_when_full

  def no_multiple_leaders
    if team_id.present? && Membership.where(team_id: self.team_id, team_leader: true).any? && team_leader == true
      errors.add(:team_leader, "cannot have multiple!")
    end
  end

  def no_more_members_when_full
    max_members = Team.find(self.team_id).max_members
    if team_id.present? && Membership.where(team_id: self.team_id).count >= max_members
      errors.add(:team_id, "cannot have more than #{max_members} members!")
    end
  end
end
