class Purchase < ApplicationRecord

	belongs_to :user
	belongs_to :ticket

	enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

end
