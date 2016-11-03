shared_examples_for :rsvpable do
  let(:rsvpable) { create(described_class.name.underscore) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
end
