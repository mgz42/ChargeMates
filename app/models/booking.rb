class Booking < ApplicationRecord
  belongs_to :vehicle
  belongs_to :station
  has_many :messages
  has_many :conflicts
end
