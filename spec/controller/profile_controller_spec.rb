require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  describe 'user not signed in' do
    let(:user) { create(:user) }

    before do
      get :show, params: { id: user }
    end

    it { expect(response).to redirect_to new_user_session_path }
  end

  describe 'user signed in' do
    let(:user) { create(:user) }

    before do
      sign_in user #User needs to sign in to create new tweet
    end

    describe 'GET #show' do
      let(users) { create_list(:user, 2) }
      let!(tweets) { create_list(:tweet, 3, user_id: users[0].id) }
      let!(tweets2) { create_list(:tweet, 3, user_id: users[1].id) }
      before do
        get :show, params: { id: users[0].id }
      end

      it { expect(User.count).to eq(2) }
      it { expect(Tweet.count).to eq(3) }
      it { expect(assigns(:user)).to eq(users[0]) }
      it { expect(assigns(:tweets)).to eq(tweets) }

    end
  end


end
