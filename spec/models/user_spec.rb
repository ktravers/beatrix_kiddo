require 'rails_helper'

describe User do
  let(:user)  { create(:user) }
  let(:event) { create(:event) }

  it { is_expected.to have_many(:rsvps) }
  it { is_expected.to have_many(:events) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).scoped_to(:first_name, :last_name) }

  describe '#full_name' do
    it 'builds full name out of first and last name' do
      expect(user).to respond_to(:full_name)
      expect(user.full_name).to be_kind_of(String)
      expect(user.full_name).to start_with user.first_name
      expect(user.full_name).to end_with user.last_name
    end
  end

  describe '#invited_to?' do
    context 'when user invited to event' do
      it 'returns true' do
        create(:rsvp, user_id: user.id, event_id: event.id)
        expect(user.invited_to?(event.id)).to be true
      end
    end

    context 'when user not invited to event' do
      it 'returns false' do
        expect(user.invited_to?(event.id)).to be false
      end
    end
  end

  describe '#rsvped_to?' do
    context 'when user rsvped to event' do
      it 'returns true' do
        create(:rsvp,
          user_id: user.id,
          event_id: event.id,
          accepted_at: Time.now
        )
        expect(user.rsvped_to?(event.id)).to be true
      end
    end

    context 'when user not rsvped to event' do
      it 'returns false' do
        expect(user.rsvped_to?(event.id)).to be false
      end
    end
  end

  describe '#attending?' do
    context 'when user attending event' do
      it 'returns true' do
        create(:rsvp,
          user_id: user.id,
          event_id: event.id,
          accepted_at: Time.now
        )
        expect(user.attending?(event.id)).to be true
      end
    end

    context 'when user not attending event' do
      it 'returns false' do
        create(:rsvp,
          user_id: user.id,
          event_id: event.id,
          declined_at: Time.now
        )
        expect(user.attending?(event.id)).to be false
      end
    end
  end
end
