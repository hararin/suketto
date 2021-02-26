class Report < ApplicationRecord

	belongs_to :user

	validates :content, presence: true
	validates :respondent_id, presence: true

end
