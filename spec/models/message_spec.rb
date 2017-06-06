require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:from_user).class_name("User") }
  it { should validate_presence_of(:from_user_id) }

  it { should belong_to(:to_user).class_name("User") }
  it { should validate_presence_of(:to_user_id) }

end

