class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  validates :price, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def duration
    d = self.end_time - self.start_time
    t = 86400
    return (d/t).to_i
  end
end
