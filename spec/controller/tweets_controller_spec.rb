require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe 'GET #index' do
    let(:tweets) { create_list(:tweet, 3) }

    before do
      get :index
    end

    it { expect(assigns(:tweets)).to eq(tweets) }
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    before do
      sign_in user #User needs to sign in to create new tweet
      get :new
    end

    it { expect(assigns(:tweet)).to be_a_new_record }
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    before do
      sign_in user
      #post :create, params: { tweet: { body: params, user_id: user } }
      post :create, params: { tweet: params }
    end
    context 'when tweet#save passes' do
      #let(:params) { "dsadas"}
      let(:params) { attributes_for(:tweet) }
      it { expect(Tweet.count).to eq(1)}
      it { expect(response).to redirect_to tweets_path }
    end

    context 'when tweet#save fails' do
      #let(:params) { nil }
      let(:params) { attributes_for(:tweet) }
      it { expect(Tweet.count).to eq(0) }
      it { expect(response).to render_template(:new) }
    end

  end

end
