class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:team_id], :message => "cant be in the same team twice"
  validates :user_id, numericality: { only_integer: true }
  validates :team_id, numericality: { only_integer: true }
  validate :no_multiple_leaders

  def no_multiple_leaders
    if team_id.present? && Membership.where(team_id: self.team_id, team_leader: true).any?
      errors.add(:team_leader, "cannot have multiple!")
    end
  end
end
