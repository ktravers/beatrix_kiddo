require 'rails_helper'

describe Event do
  it { is_expected.to have_many(:users) }

  it { is_expected.to validate_uniqueness_of(:name) }

  describe '#venue_map_url' do
    it 'builds google map url for venue' do
    end
  end

  describe '#gcal_url' do
    it 'generates google calendar new event url' do
    end
  end

  describe '#to_ics' do
    it 'generates new iCal event' do
    end
  end
end
