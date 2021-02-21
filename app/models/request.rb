class Request < ApplicationRecord

	belongs_to :user
	has_many :participants, dependent: :destroy

 	validates :datetime, presence: true
  	validates :address, presence: true
  	validates :title, presence: true

  	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	attachment :image
end
