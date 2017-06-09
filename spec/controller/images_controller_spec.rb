require 'rails_helper'

RSpec.describe ImagesController, type: :controller do

  context 'user signed in' do
    let(:user) {create(:user)}
    before do
      sign_in user
    end

    describe 'DELETE #destroy' do
      let(:tweet) {create(:tweet, user_id: user.id ) }
      let!(:images) {create_list(:image, 3, tweet_id: tweet.id) }

      before do
        delete :destroy, xhr: true, params: { id: images[0].id }
      end
      it { expect(Tweet.count).to eq(1) }
      it { expect(Image.count).to eq(2) }
      it { expect(response).to render_template(:destroy)}
    end

  end

end
