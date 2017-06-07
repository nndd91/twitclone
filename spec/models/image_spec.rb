require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should validate_presence_of(:tweet_id) }
  it { should belong_to(:tweet) }
end
