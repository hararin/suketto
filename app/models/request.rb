class Request < ApplicationRecord

	belongs_to :user
	has_many :participants, dependent: :destroy

 	validates :datetime, presence: true
  	validates :address, presence: true
  	validates :title, presence: true

  	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	attachment :image

  	def ticket_return(request)
      if request.return_status == 0
        request.user.update(ticket: request.user.ticket + request.capacity - request.participants.count)
        request.update(return_status: 1)
      else
        return
      end
  	end
end