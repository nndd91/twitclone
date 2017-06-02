require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe 'user not signed in' do
    before do
      get :index
    end

    it { expect(response).to redirect_to new_user_session_path }
  end

  describe 'user signed in' do
    let(:user) { create(:user) }

    before do
      sign_in user #User needs to sign in to create new tweet
    end

    describe 'GET #index' do
      let(:tweets) { create_list(:tweet, 3) }

      before do
        get :index
      end

      it { expect(assigns(:tweets)).to eq(tweets) }
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it { expect(assigns(:tweet)).to be_a_new_record }
    end

    describe 'POST #create' do
      before do
        post :create, params: { tweet: params }
      end

      context 'when tweet#save passes' do
        let(:params) { attributes_for(:tweet) }
        it { expect(Tweet.count).to eq(1)}
        it { expect(response).to redirect_to tweets_path }
      end

      context 'when tweet#save fails' do
        let(:params) { attributes_for(:tweet, :invalid) }
        it { expect(Tweet.count).to eq(0) }
        it { expect(response).to render_template(:new) }
      end
    end

    describe 'DELETE #destroy' do
      let!(:tweets) { create_list(:tweet, 3) }

      before do
        delete :destroy, params: { id: tweets[1] }
      end

      context 'when tweet#destroy successfully' do
        it { expect(Tweet.count).to eq(2) }
        it { expect(response).to redirect_to tweets_path }
      end
    end

    describe 'get #edit' do
      let!(:tweet) { create(:tweet) }

      before do
        get :edit, params: { id: tweet }
      end

      it { expect(assigns(:tweet)).to eq(tweet) }
    end

    describe 'PUT #update' do
      let!(:tweet) { create(:tweet) }

      before do
        put :update, params: { tweet: { body: "Edited" }, id: tweet.id }
      end

      it { expect(Tweet.find(tweet.id).body).to eq("Edited") }
    end

    describe 'GET #show' do
      let(:tweet) { create(:tweet) }

      before do
        get :show, params: { id: tweet.id }
      end

      it { expect(assigns(:tweet)).to eq(tweet) }
    end

    describe 'get #feed' do
      let(:user2) { create(:user) }
      let!(:following) { create(:following, follower: user, followed: user2) }
      let(:tweets) { create_list(:tweet, 3, user: user2) }
      let(:usertweets) { create_list(:tweet, 3, user: user) }
      let!(:all_tweets) { tweets + usertweets }

      before do
        get :feed
      end

      it { expect(Following.count).to eq(1) }
      it { expect(Tweet.count).to eq(6) }
      it { expect(assigns(:user)).to eq(user) }
      it { expect(assigns(:following)).to eq([following.followed_id]) }
      it { expect(assigns(:tweets)).to eq(all_tweets) }
    end

  end
end
