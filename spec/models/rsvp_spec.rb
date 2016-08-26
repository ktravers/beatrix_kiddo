require 'rails_helper'

describe Rsvp do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:event) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:event) }
  it { is_expected.to validate_uniqueness_of(:user_id) }  
end
