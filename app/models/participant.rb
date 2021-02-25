class Participant < ApplicationRecord

	belongs_to :user
	belongs_to :request

	validates :user_id, presence: true
	validates :request_id, presence: true

end
