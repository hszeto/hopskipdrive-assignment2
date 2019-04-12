class Ride < ApplicationRecord
  belongs_to :repeating_ride

  def update_ride(data)
    self.update(data)
  end

  def delete_ride
    self.destroy
  end
end
