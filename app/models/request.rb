class Request < ApplicationRecord

	belongs_to :user
	has_many :participants, dependent: :destroy

 	validates :datetime, presence: true
  	validates :address, presence: true
  	validates :title, presence: true
    validates :capacity, presence: true
    validates :deadline, presence: true
    validates :return_status, presence: true
    validates :user_id, presence: true

  	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	attachment :image

  	def ticket_return(request)
      if request.return_status == 0
        if DateTime.now >= request.datetime
          request.user.update(ticket: request.user.ticket + request.capacity - request.participants.count)
          request.update(return_status: 1)
        end
      end
  	end

    def ticket_return_ban(request)
      if request.return_status == 0
        request.user.update(ticket: request.user.ticket + request.capacity)
        request.update(return_status: 1)
      end
    end

    def ticket_return_destroy(request)
      if request.return_status == 0
        request.user.update(ticket: request.user.ticket + request.capacity)
        request.update(return_status: 1)
        @participants = request.participants.all
        @participants.each do |participant|
          participant.user.update(ticket: participant.user.ticket - 1)
        end
      end
    end

end