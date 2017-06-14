require 'rails_helper'

RSpec.describe Mention, type: :model do
  it { should belong_to(:tweet) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:tweet) }
  it { should validate_presence_of(:user) }
end
