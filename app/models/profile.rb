class Profile < ApplicationRecord
  belongs_to :user

  has_many :bookings

  validates :category, :price, presence: true
end
