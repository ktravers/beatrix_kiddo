require 'rails_helper'

describe Rsvp do
  describe 'validations' do
    subject { FactoryGirl.build(:rsvp) }

    it_behaves_like :rsvpable

    it { is_expected.to belong_to(:event) }
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:event_id) }
  end
end
