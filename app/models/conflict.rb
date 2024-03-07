class Conflict < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  validates :title, presence: true
end
