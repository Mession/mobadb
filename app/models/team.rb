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
    if year.present? && year > Date.today.year # mita eroa jos Time.now.year?
      errors.add(:year, "cannot be in the future!")
    end
  end
end
