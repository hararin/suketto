require 'rails_helper'

RSpec.describe 'Purchase', type: :feature do
	before do
		@banned_user = create(:user1, :banned_user)
		visit new_user_session_path
		fill_in 'user[email]', with: @banned_user.email
		fill_in 'user[password]', with: @banned_user.password
		click_on 'commit'
	end
	describe 'banされたユーザー' do
		context 'チケット購入画面に遷移' do
			it '遷移できる' do
				visit new_users_purchase_path
				expect(page).to have_content 'TICKETS'
			end
		end
		context 'チケット購入' do
			it '購入できない' do
				visit new_users_purchase_path
				click_on '購入する'
				expect(page).to have_content 'このアカウントは停止中のため一部の機能を利用できません。'
			end
		end
	end
end