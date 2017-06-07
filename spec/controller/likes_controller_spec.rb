require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  context 'User not signed in' do
    let(:user) { create(:user) }
    let!(:tweet) { create(:tweet, user: user) }

    before do
      post :create, params: { tweet_id: tweet.id, user_id: user}
    end

    it { expect(response).to redirect_to new_user_session_path }
  end

  context 'User signed in' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe 'POST #create' do
      let!(:tweet) { create(:tweet, user: user) }
      # let!(:like) { create(:like, tweet: tweet, user: user) }

      before do
        post :create, xhr: true, params: { tweet_id: tweet.id, user_id: user}
      end

      it { expect(User.count).to eq(1) }
      it { expect(Tweet.count).to eq(1) }
      it { expect(Like.count).to eq(1) }
      it { expect(response).to render_template(:create) }
    end

    describe 'DELETE #destroy' do
      let(:tweet) { create(:tweet, user: user) }
      let(:tweet2) { create(:tweet, user: user) }
      let!(:like) { create(:like, tweet: tweet, user: user) }
      let!(:like2) { create(:like, tweet: tweet2, user: user) }

      before do
        delete :destroy, xhr: true, params: { id: like, tweet: tweet }
      end

      it { expect(User.count).to eq(1) }
      it { expect(Tweet.count).to eq(2) }
      it { expect(Like.count).to eq(1) }
      it { expect(response).to render_template(:destroy) }

    end
  end

end
