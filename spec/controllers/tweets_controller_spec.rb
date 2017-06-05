require 'rails_helper'

RSpec.describe TweetsController, type: :controller do 

	describe 'GET #index' do
	#Set up
	let(:tweet) { create(:tweet) }
	#Preparation
	context 'when signed in as user' do
		before { sign_in user }
	end
	context 'when not signed in as user' do
		it { expect(response).to redirect_to(root_path) }
	end

	#Assertion, take note that the assign method is taking the variable from your controller
	it { expect(assigns(:tweet)).to eq(tweet) }

	end

	describe '#new' do 
	#Set up
	let(:tweet) { create(:tweet) }
	#Preparation
	context 'when signed in as user' do
		before { sign_in user }

	end
	context 'when not signed in as user' do
		it { expect(response).to redirect_to(root_path) }
	end

	#Assertion, take note that the assign method is taking the variable from your controller
	it { expect(assigns(:relationship)).to eq(relationship)}

end

describe '#create' do 
	#Set up
	let(:user){create(:user)}

	#Preparation
	
	context 'when signed in as user' do
		before { sign_in user }
	
		before { post :create, params: { tweet:{ user_id: user, body: 'Test' } } }

	#Assertion, take note that the assign method is taking the variable from your controller
		it { expect(assigns(:tweet)).to have_attributes(user: user, body: 'Test') }
		it { is_expected.to redirect_to tweets_path }
	end
end

describe '#destroy' do 
	let(:tweet) { create(:tweet) }

	before { delete :destroy, id: tweet.id }

	it { expect(Tweet.count).to eq(0) }
	it { is_expected.to redirect_to root_path }
end

describe '#edit' do
end

describe '#update' do
end

describe '#show' do
	let(:tweet) { create(:tweet) }

	#Preparation
	context 'when signed in as user' do
		before { sign_in user }
	end

	context 'when not signed in as user' do
		it { expect(response).to redirect_to(root_path) }
	end

end

describe '#feed' do

end

end





def destroy
	@tweet.destroy
	redirect_to tweets_path
end

def edit
	@tweet = Tweet.find(params[:id])
end

def update
	@tweet = Tweet.find(params[:id])
	@tweet.update(tweet_params)
	redirect_to tweets_path
end


def feed
	@user = current_user
	@following = current_user.following_ids
	@tweets = Tweet.get_tweets(@following, current_user.id)
end
