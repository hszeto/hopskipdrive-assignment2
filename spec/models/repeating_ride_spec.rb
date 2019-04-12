RSpec.describe RepeatingRide, type: :model do
  # routine = 8:00 AM. Monday, Wednesday, Friday. Repeat 3 weeks
  let!(:routine){ create :repeating_ride }

  it { should belong_to(:user) }

  it 'create a routine' do
    expect(RepeatingRide.count).to eq 1
    expect(RepeatingRide.last.days).to eq [1, 3, 5]
    expect(RepeatingRide.last.frequency).to eq 3
    expect(RepeatingRide.last.location).to eq routine.location
  end

  describe 'CRUD rides from repeating_ride' do
    it 'create 3 rides per week for 3 weeks (frequency == 3)' do
      # ap Ride.last.repeating_ride.user
      expect(Ride.count).to be >= 7
    end

    it 'update all rides' do
      routine.rides.update_all(time: '9:00 AM')

      expect(Ride.last[:time]).to eq '9:00 AM'
    end

    it 'delete all rides' do
      routine.rides.destroy_all

      expect(RepeatingRide.count).to eq 1
      expect(Ride.count).to be 0
    end

    it 'update 1 ride' do
      updated_ride = routine.rides.last
      updated_ride.update(time: '10:00 AM')

      expect(routine.rides.first[:time]).to eq '8:00 AM'
      expect(updated_ride[:time]).to eq '10:00 AM'
    end

    it 'delete 1 ride' do
      original_rides = RepeatingRide.last.rides

      original_rides[2].destroy

      # RepeatingRide.last.rides is 1 less
      expect(original_rides.size - RepeatingRide.last.rides.size).to eq 1
    end
  end
end
