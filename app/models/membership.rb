class Membership < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => [:team_id], :message => "cant be in the same team twice"

  belongs_to :team
  belongs_to :user
end
