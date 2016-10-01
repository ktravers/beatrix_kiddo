require 'rails_helper'

describe User do
  describe 'validations' do
    subject { FactoryGirl.build(:user) }

    it { is_expected.to have_many(:rsvps) }
    it { is_expected.to have_many(:events).through(:rsvps) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:first_name, :last_name) }
  end

  describe '#full_name' do
    let(:user)  { create(:user) }

    it 'builds full name out of first and last name' do
      expect(user).to respond_to(:full_name)
      expect(user.full_name).to be_kind_of(String)
      expect(user.full_name).to start_with user.first_name
      expect(user.full_name).to end_with user.last_name
    end
  end
end
