class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:team_id], :message => "cant be in the same team twice"
  validates :user_id, numericality: { only_integer: true }
  validates :team_id, numericality: { only_integer: true }
  validate :no_multiple_leaders
  validate :no_more_members_when_full

  def no_multiple_leaders
    if team_id.present? and Membership.where(team_id: self.team_id, team_leader: true).any? and team_leader
      errors.add(:team_leader, "cannot have multiple!")
    end
  end

  def no_more_members_when_full
    max_members = Team.find_by(id: self.team_id).max_members
    return true if max_members.nil? # seedatessa tuli erroria, pitaa testata tata
    if team_id.present? and Membership.where(team_id: self.team_id).count >= max_members
      errors.add(:team_id, "cannot have more than #{max_members} members!")
    end
  end
end
