require 'rails_helper'

describe PlusOne do
  describe 'validations' do
    subject { FactoryGirl.build(:plus_one) }

    it_behaves_like :rsvpable

    it { is_expected.to belong_to(:rsvp) }
    it { is_expected.to validate_presence_of(:rsvp) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:rsvp_id) }
  end

  describe '#full_name' do
    let(:user) { build(:user) }
    let(:rsvp) { build(:rsvp) }

    context 'when guest' do
      let(:guest)    { build(:user) }
      let(:plus_one) { build(:plus_one, user: user, rsvp: rsvp, guest: guest) }

      it 'returns guest full name' do
        expect(plus_one.full_name).to eq guest.full_name
      end
    end

    context 'when no guest' do
      let(:plus_one) { build(:plus_one, user: user, rsvp: rsvp) }

      it 'returns user full name +1' do
        expect(plus_one.full_name).to match(/#{user.full_name}/)
        expect(plus_one.full_name).to match(/\+1/)
      end
    end
  end
end
