  CAT = [ "Handicap mental", "Handicap sensoriel", "Handicap moteur", "Handicap psychique", "Maladies invalidantes", "Grossesse", "Vieillesse" ]
class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :category, inclusion: { in: CAT }
  validates :category, :price, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
