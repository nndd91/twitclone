require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:user).class_name("User") }
  it { should belong_to(:tweet).class_name("Tweet") }

  it { should validate_presence_of(:user_id) }

  it { should validate_uniqueness_of(:tweet_id).scoped_to(:user_id).
    with_message("User can only like tweet once!") }

  it { should validate_presence_of(:tweet_id) }
end
