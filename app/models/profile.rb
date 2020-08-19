  CAT = [ "Handicap mental", "Handicap sensoriel", "Handicap moteur", "Handicap psychique", "Maladies invalidantes" ]
class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :category, inclusion: { in: CAT }
  validates :category, :price, presence: true
end
