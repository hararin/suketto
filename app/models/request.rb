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
      count = 1
      lambda do
        return if count == nil
        request.user.update(ticket: request.user.ticket + request.capacity - request.participants.count)
        count = nil
        yield
      end
  	end
end
