require 'rails_helper'

describe Event do
  describe 'validations' do
    subject { FactoryGirl.build(:event) }

    it { is_expected.to have_many(:rsvps) }
    it { is_expected.to have_many(:users).through(:rsvps) }

    it { is_expected.to validate_uniqueness_of(:name) }
  end

  let(:event) { create(:event) }

  describe '#venue_map_url' do
    it 'builds google map url for venue' do
      expect(event.venue_map_url).to be_kind_of(String)
      expect(event.venue_map_url).to start_with Event::GOOGLE_MAP_BASE_URL
    end
  end

  describe '#gcal_url' do
    it 'generates google calendar new event url' do
      expect(event.gcal_url).to be_kind_of(String)
    end
  end

  describe '#to_ics' do
    it 'generates new iCal event' do
      expect(event.to_ics).to be_kind_of(Icalendar::Calendar)
    end
  end
end
