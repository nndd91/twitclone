require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do

  describe 'POST #create' do

    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    before do
      sign_in user
      post :create, params: { follower_id: user, followed_id: user2, profile_id: user2}
    end

    context 'when user#followes passes' do
      it { expect(response).to redirect_to profile_path(user2) }
    end

    context 'when user#follows fails' do
      it { expect(response).to render_template(:new) }
    end

  end


end
