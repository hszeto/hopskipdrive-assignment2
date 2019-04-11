RSpec.describe User, type: :model do
  let!(:user) { create :user}

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email) }

  it { should have_many(:repeating_rides) }

  it 'create an user' do
    expect(User.count).to eq 1
  end
end
