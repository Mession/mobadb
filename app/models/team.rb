class Team < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  belongs_to :game

  scope :accepted_members, -> { where invitation_status: 1 }
  scope :invited_members, -> { where invitation_status: 2 }
  scope :declined_members, -> { where invitation_status: 0 }

  validates :name, presence: true
  validates :game_id, presence: true, numericality: { only_integer: true }
  validates :year, allow_blank: true, numericality: { greater_than_or_equal_to: 2003, only_integer: true }
  validates :max_members, allow_blank: true, numericality: { greater_than_or_equal_to: 3, only_integer: true }
  validate :year_not_in_future

  def year_not_in_future
    if year.present? and year > Date.today.year # mita eroa jos Time.now.year? tai kuten ratebeerissa ilman omaa validationia https://github.com/mluukkai/WebPalvelinohjelmointi2014/blob/master/malliv/viikko6/app/models/brewery.rb
      errors.add(:year, "cannot be in the future!")
    end
  end


  def accepted_members
    return get_filtered_members(1)
  end

  def invited_members
    return get_filtered_members(2)
  end

  def declined_members
    return get_filtered_members(0)
  end

  private
    def get_filtered_members (invitation_status)
      m = self.memberships
      filtered_members = Array.new

      m.each do |membership|
        filtered_members.push membership.user if membership.invitation_status == invitation_status
      end

      return filtered_members
    end

end
