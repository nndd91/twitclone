require 'rails_helper'

RSpec.describe Tweet, type: :model do

  it do
    should validate_length_of(:body).
                 is_at_most(140).
                 on(:create)
  end

  it { should validate_presence_of(:body) }
end