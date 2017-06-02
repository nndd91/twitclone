require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  context 'user not signed in' do
    let(:user) { create(:user) }

    before do
      get :show, params: { id: user }
    end

    it { expect(response).to redirect_to new_user_session_path }
  end

  context 'user signed in' do
    let(:user) { create(:user) }
    # Most methods requires users checking so creating them here.
    let(:users) { create_list(:user, 2) }

    before do
      sign_in user #User needs to sign in to create new tweet
    end

    describe 'GET #show' do

      let!(:tweets) { create_list(:tweet, 3, user_id: users[0].id) }
      let!(:tweets2) { create_list(:tweet, 3, user_id: users[1].id) }
      let!(:following) { create(:following, follower: user, followed: users[0])}
      #let! otherwise the following will not be created when tests runs
      before do
        get :show, params: { id: users[0].id }
      end

      it { expect(User.count).to eq(3) }
      it { expect(Tweet.count).to eq(6) }
      it { expect(assigns(:tweets)).to eq(tweets) }
      it { expect(assigns(:user)).to eq(users[0]) }
      it { expect(assigns(:following)).to eq(following) }
    end

    describe 'GET #get_following' do
      let!(:following) { create(:following, follower: users[0], followed: user) }

      before do
        get :get_following, params: { id: users[0] }
      end

      it { expect(assigns(:user)).to eq(users[0]) }
      it { expect(assigns(:relationship).first).to eq(user) }

    end

    describe 'GET #get_followers' do
      let!(:following) { create(:following, follower: user, followed: users[0]) }

      before do
        get :get_followers, params: { id: users[0] }
      end

      it { expect(assigns(:user)).to eq(users[0]) }
      it { expect(assigns(:relationship).first).to eq(user)}
    end
  end
end
