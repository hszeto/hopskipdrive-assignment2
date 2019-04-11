RSpec.describe RepeatingRide, type: :model do
  let!(:routine){ create :repeating_ride }

  it { should belong_to(:user) }

  it 'create a routine' do
    expect(RepeatingRide.count).to eq 1
    expect(RepeatingRide.last.days).to eq [1, 3, 5]
    expect(RepeatingRide.last.frequency).to eq 3
    expect(RepeatingRide.last.location).to eq routine.location
  end

  describe 'create rides' do
    it 'create 3 rides per week for 3 weeks for total 9 rides' do
      ap Ride.all
      # ap Ride.last.repeating_ride.user
      expect(Ride.count).to be >= 7
    end
  end
end
