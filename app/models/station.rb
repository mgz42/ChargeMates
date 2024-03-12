class Station < ApplicationRecord
  belongs_to :user
  # has_one :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :address, presence: true
  validates :plug, presence: true
  validates :brand, presence: true
  validates :model, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


end
