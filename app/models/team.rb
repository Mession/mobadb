class Team < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  belongs_to :game

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

  # obsolete toistaiseksi, ei kuitenkaan poisteta koska hienot testit
  def declined_members
    return get_filtered_members(0)
  end

  def get_team_role_ratings
    role_ratings = Array.new

    accepted_members.each do |member|
      member.role_ratings.each do |rating|
        role_ratings.push rating if rating.game_id == self.game_id
      end
    end

    return role_ratings
  end

  def get_team_character_ratings
    character_ratings = Array.new

    accepted_members.each do |member|
      member.champ_ratings.each do |rating|
        character_ratings.push rating if rating.game == self.game
      end
    end

    return character_ratings
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
