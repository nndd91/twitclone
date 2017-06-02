require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do

  describe 'POST #create' do

    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    before do
      sign_in user
      post :create, params: { follower_id: user, followed_id: params, profile_id: user2}
    end

    context 'when user#followes passes' do
      let(:params) { user2 }
      it { expect(Following.count).to eq(1) }
      it { expect(response).to redirect_to profile_path(user2) }
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let!(:following) { create(:following, follower: user, followed: user2) }
    let!(:following2) { create(:following, follower: user2, followed: user) }
    before do
      sign_in user #user must be signed in to unfollow
      delete :destroy, params: { following_id: following, id: user2 }
    end

    it { expect(Following.count).to eq(1) }
    it { expect(response).to redirect_to profile_path(user2)}
  end

end
