class Role < ActiveRecord::Base
  has_many :role_ratings
  has_many :users, through: :role_ratings

  validates :name, presence: true
end
