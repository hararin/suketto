require 'rails_helper'

RSpec.describe 'User', type: :feature do
	before do
		@user = create(:user1)
		@user2 = create(:user2)
		@user3 = create(:user3)
		@banned_user = create(:user1, :banned_user)
		@deleted_user = create(:user1, :deleted_user)
	end
	describe '通常のユーザー1' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: @user.email
			fill_in 'user[password]', with: @user.password
			click_on 'commit'
		end
		context '退会する' do
			it '進行中の依頼があるため退会できない。' do
				visit edit_users_customer_path(@user)
				click_on '退会する'
				expect(page).to have_content "進行中の依頼があるため退会できません。"
			end
		end
	end
	describe '通常のユーザー２' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: @user2.email
			fill_in 'user[password]', with: @user2.password
			click_on 'commit'
		end
		context '退会する' do
			it '進行中の助っ人があるため退会できない' do
				visit edit_users_customer_path(@user2)
				click_on '退会する'
				expect(page).to have_content "進行中の助っ人があるため退会できません。"
			end
		end
	end
	describe '通常のユーザー3' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: @user3.email
			fill_in 'user[password]', with: @user3.password
			click_on 'commit'
		end
		context '退会する' do
			it '退会できる' do
				visit edit_users_customer_path(@user3)
				click_on '退会する'
				expect(page).to have_content "Let's become a \"Suketto\"!"
			end
		end
	end
	describe 'banされたユーザー' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: @banned_user.email
			fill_in 'user[password]', with: @banned_user.password
			click_on 'commit'
		end
		context 'ログインする' do
			it 'ログインできる' do
				expect(page).to have_content 'ログインしました。'
			end
			it 'マイページに遷移する' do
				expect(page).to have_content @banned_user.name
			end
		end
		context '他のユーザーの詳細画面に遷移する' do
			it '遷移できる' do
				visit users_customer_path(@user)
				expect(page).to have_content @user.name
			end
		end
	end
	describe '退会済みのユーザー' do
		context 'ログインする' do
			it 'ログインできない' do
				visit new_user_session_path
				fill_in 'user[email]', with: @deleted_user.email
				fill_in 'user[password]', with: @deleted_user.password
				click_on 'commit'
				expect(page).to have_content '退会済みです'
			end
		end
	end
end