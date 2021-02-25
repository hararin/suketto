class Purchase < ApplicationRecord

	belongs_to :user
	belongs_to :ticket

	validates :payment_method, presence: true
	validates :charge, presence: true
	validates :quantity, presence: true
	validates :ticket_id, presence: true
	validates :user_id, presence: true

	enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

end
