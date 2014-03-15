class User < ActiveRecord::Base
  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3 }, length: { maximum: 15 }

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
end
