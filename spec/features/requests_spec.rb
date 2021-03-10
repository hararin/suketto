require 'rails_helper'

RSpec.describe 'Request', type: :feature do
	before do
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
		context '依頼作成画面に遷移する' do
			it '遷移できない' do
				visit new_users_request_path
				expect(page).to have_content "このアカウントは停止中のため一部の機能を利用できません。"
			end
		end
		context '依頼編集画面に遷移する' do
			it '遷移できない' do
				visit edit_users_request_path(@request)
				expect(page).to have_content "このアカウントは停止中のため一部の機能を利用できません。"
			end
		end
		context '一覧画面に遷移する' do
			it '遷移できる' do
				visit users_requests_path
				expect(page).to have_content "REQUESTS"
			end
		end
		context '依頼詳細画面に遷移する' do
			it '遷移できる' do
				visit users_request_path(@request)
				expect(page).to have_content "REQUEST"
			end
		end
	end

end