require 'rails_helper'

RSpec.describe Request, type: :model do
	before do
		@user1 = create(:user1)
		@user2 = create(:user2)
		@request = create(:request)
		@request2 = create(:request, :request2)
		@request3 = create(:request, :request3)
		@participant = create(:participant)
	end

	describe 'ticket_returnメソッド' do
		before do
			@request3.ticket_return(@request3)
		end
		it 'user1のticketは24になること' do
			expect(@request3.user.ticket).to eq(20 + 5 - 1)
		end
		it 'return_statusは1になること' do
			expect(@request3.return_status).to eq(1)
		end
	end

	describe 'ticket_return_banメソッド' do
		before do
			@request.ticket_return_ban(@request)
		end
		it 'user1のticketは25になること' do
			expect(@request.user.ticket).to eq(20 + 5)
		end
		it 'return_statusは1になること' do
			expect(@request.return_status).to eq(1)
		end
		it 'user2のticketは30であること' do
			expect(@participant.user.ticket).to eq(30)
		end
	end

	describe 'ticket_return_destroyメソッド' do
		before do
			@request.ticket_return_destroy(@request)
		end
		it 'user1のticketは25になること' do
			expect(@request.user.ticket).to eq(20 + 5)
		end
		it 'return_statusは1になること' do
			expect(@request.return_status).to eq(1)
		end
		it 'user2のticketは29になること' do
			expect(@participant.user.ticket).to eq(30 - 1)
		end
	end

	describe 'return_statusが1の場合' do
		context 'ticket_returnメソッド' do
			it 'user1のticketは20のままであること' do
				@request2.ticket_return(@request2)
				expect(@request2.user.ticket).to eq(20)
			end
		end
		context 'ticket_return_banメソッド' do
			it 'user1のticketは20のままであること' do
				@request2.ticket_return_ban(@request2)
				expect(@request2.user.ticket).to eq(20)
			end
		end
		context 'ticket_return_destroyメソッド' do
			it 'user1のticketは20のままであること' do
				@request2.ticket_return_destroy(@request2)
				expect(@request2.user.ticket).to eq(20)
			end
		end
	end
end