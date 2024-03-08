class Booking < ApplicationRecord
  belongs_to :vehicle
  belongs_to :station
  has_many :messages, dependent: :destroy
  has_many :conflicts
end
