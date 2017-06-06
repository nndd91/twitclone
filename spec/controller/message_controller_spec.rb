require 'rails_helper'

RSpec.describe MessageController, type: :controller do

  describe 'POST #create' do

    let(:user) { create(:user) } # From User
    let(:user2) { create(:user) }# To User

    before do
      sign_in user
      post :create, params: { from_user_id: user, body: params, to_user_id: user2}
    end

    context 'when user#message passes' do
      let(:params) { user }
      it { expect(Message.count).to eq(1) }
      it { expect(response).to redirect_to message_path(params[user]) }
    end
  end
  describe 'GET #index' do

  let(:userid) { create_list(:from_user_id, :body, :to_user_id) }

  before do
    sign_in user
    get :index
  end

  it { expect(assigns(:message)).to eq(msgid) }
  
  end
  
  describe 'GET #show' do

    let(:msgid) { create(:from_user_id, :body, :to_user_id) }

    before do
      sign_in user
      get :show, params: { id: msgid }
    end
    it { expect(assigns(:message)).to eq(msgid) }
  end

  describe 'DELETE #destroy' do
      let!(:body) { create_list() }

      before do
        delete :destroy, params: { id: body[1] }
      end

      context 'when message#destroy successfully' do
        it { expect(Message.count).to eq(0) }
        it { expect(response).to redirect_to message_path }
      end
  end

end
