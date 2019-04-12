class RepeatingRide < ApplicationRecord
  serialize :days

  belongs_to :user
  has_many :rides, dependent: :destroy

  after_create :generate_rides
  after_update :update_rides

  ###################################################################
  # Frequency: Number of recurring week. 1 to 4 weeks.
  # Day of the week: [0,1,2,3,4,5,6]. 0 is Sunday. 6 is Saturday.
  # Week number: Week number of the year.The week starts with Sunday.
  ###################################################################

  def generate_rides
    (1..self.frequency).each do |freq|
      self.days.each do |day_of_the_weak|
        week_number = Time.now.strftime("%U").to_i + freq
        year = self.created_at.year

        date = Date.commercial(year, week_number, day_of_the_weak)
                   .to_s

        next if Time.parse(date) < Time.now.to_date

        self.rides.create!(
          date: date,
          time: self.time,
          location: self.location
        )
      end
    end
  end

  def update_rides(data)
    self.rides.update(data)
  end

  def delete_all_rides
    self.rides.destroy_all
  end

  # def serialize_response
  #   attributes.select{ |k,v| k != 'created_at' && k != 'updated_at' }
  # end
end
