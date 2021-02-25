class Ticket < ApplicationRecord

	has_many :purchases

	validates :name, presence: true
	validates :price, presence: true
	validates :quantity, presence: true

end
