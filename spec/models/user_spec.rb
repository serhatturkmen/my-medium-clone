require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to(have_many(:posts)) }
  it { is_expected.to(have_many(:comments)) }

  it { is_expected.to(validate_length_of(:username).is_at_least(5).is_at_most(50)) }

  it { is_expected.to(validate_presence_of(:username)) }
  it { is_expected.to(validate_presence_of(:email)) }

end
