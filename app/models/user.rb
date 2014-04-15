class User < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3 }, length: { maximum: 15 }

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :role_ratings, dependent: :destroy
  has_many :roles, through: :role_ratings
  has_many :champ_ratings, dependent: :destroy
end
