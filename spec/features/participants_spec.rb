require 'rails_helper'

RSpec.describe 'Participant', type: :feature do
	before do
		@user = create(:user1)
		@request = create(:request)
		@banned_user = create(:user1, :banned_user)
	end
	describe 'banされたユーザー' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: @banned_user.email
			fill_in 'user[password]', with: @banned_user.password
			click_on 'commit'
		end
		context '助っ人登録する' do
			it '登録できない' do
				visit users_request_path(@request)
				click_on "助っ人になる"
				expect(page).to have_content 'このアカウントは停止中のため一部の機能を利用できません。'
			end
		end
	end
end