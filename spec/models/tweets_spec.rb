require 'rails_helper'

RSpec.describe Tweet, type: :model do

  it do
    should validate_length_of(:body).
                 is_at_most(140).
                 on(:create)
  end

  it { should validate_presence_of(:body) }
  it { should belong_to(:user) }

	describe '.get_tweets' do
    #Need to further work on this area
		#let(:something) { tweets }
		#let!(:job_listings){create_list(:job_listing, 3,user: user)}
	
		#it { expect(Tweet.get_tweets).to eq(something) }
	end


end

 #def self.get_tweets(following_ids, current_user_id)
  #  Tweet.where("user_id IN (?) OR user_id = ?", following_ids, current_user_id)
  #end