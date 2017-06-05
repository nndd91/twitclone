require 'rails_helper'

RSpec.describe ProfileController, type: :controller do 

	describe 'when not signed in as user' do
		before do 
			get :show, params: {id: 1}
		end

		it { expect(response).to redirect_to(new_user_session_path) }
	end

	describe 'when signed in as user' do
		let(:user) { create(:user) }
		before { sign_in user }


		describe 'GET #show' do
			#Set up
			let(:user2) { create(:user) }
			let!(:tweet) { create(:tweet, user_id: user2.id) }
			let!(:following) {create(:following, followed: user2 ,follower: user  )}
			
			before do
				get :show, params: { id: user2.id } 

			end
			# extreme end is the test variable and left end is the controller instance variable
			it { expect(assigns(:user)).to eq(user2) }
			it { expect(assigns(:tweets).first).to eq(tweet)}
			it { expect(assigns(:following)).to eq(following)}
		end

		describe 'GET #get_following' do 
				#Set up
			let(:user2) { create(:user) }
			let!(:following) { create(:following, followed: user, follower: user2 ) }
			#Preparation ( for controller)
			before do
				get :get_following, params: { id: user2.id } 
			end

			#Assertion, take note that the assign method is taking the variable from your controller
			it { expect(assigns(:relationship).first).to eq(user)}
		end

		describe 'GET #get_followers' do 
			#Set up
			let(:user2) { create(:user) }
			let(:relationship) { create(:relationship) }

			before do
				get :get_followers, params: { id: user2.id } 
			end

			#Assertion, take note that the assign method is taking the variable from your controller
			it { expect(assigns(:relationship).first).to eq(user) }
		end
	end

end