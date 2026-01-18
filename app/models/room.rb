class Room < ApplicationRecord
  has_many_attached :images

  belongs_to :user
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
end
