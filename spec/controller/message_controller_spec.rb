require 'rails_helper'

RSpec.describe MessageController, type: :controller do

  describe 'POST #create' do

    let!(:user) { create(:user) } # From User
    let!(:user2) { create(:user) }# To User

    #let(:messages) { create( :message , from_user_id: user.id, to_user_id: user2.id)}

    before do
      sign_in user
      post :create, params: { message: {from_user_id: user.id, to_user_id: user2.id, body:"guigukgkj"} }
    end

    context 'when user#message passes' do
      it { expect(Message.count).to eq(1) }
      it { expect(response).to redirect_to message_index_path }
    end
  end

  describe 'GET #new' do
    let!(:user) { create(:user) }

    before do
      sign_in user      
      get :new, xhr: true
    end

    #it { expect(assigns(:message)).to be_a_new_record }
    it { expect(response).to render_template(:new)}

  end

  describe 'GET #index' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:inbox) { create(:message, from_user_id: user2.id,  to_user_id: user.id) }
    let!(:outbox) { create(:message, from_user_id: user.id, to_user_id: user2.id) }
    
    before do
      sign_in user
      get :index
    end

    it { expect(assigns(:inbox).size).to eq(1) }
    it { expect(assigns(:outbox).size).to eq(1) }
  end
  
  #describe 'GET #show' do

   # let(:msgid) { create(:from_user_id, :body, :to_user_id) }

    #before do
     # sign_in user
      #get :show, params: { id: msgid }
    #end
    #it { expect(assigns(:message)).to eq(msgid) }
#  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
      let!(:messages) { create(:message, from_user_id: user.id, to_user_id: user2.id)}

      before do
        sign_in user
        delete :destroy, params: { id: messages.id }
      end

      context 'when message#destroy successfully' do
        it { expect(Message.count).to eq(0) }
        it { expect(response).to redirect_to message_index_path }
      end
  end

end
