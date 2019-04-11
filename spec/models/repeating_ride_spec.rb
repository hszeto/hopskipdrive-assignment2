RSpec.describe RepeatingRide, type: :model do
  let!(:routine){ create :repeating_ride }

  it { should belong_to(:user) }

  it 'create a routine' do
    ap RepeatingRide.all
    ap User.all
    expect(RepeatingRide.count).to eq 1
    expect(RepeatingRide.last.days).to eq [1, 3, 5]
    expect(RepeatingRide.last.location).to eq routine.location
  end
end
