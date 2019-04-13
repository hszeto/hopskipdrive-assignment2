module Generatable
  extend ActiveSupport::Concern

  included do
    after_create :generate_rides
  end

  ##################################################################
  # frequency: Number of recurring week. 1 to 4 weeks.
  # day_of_the_weak: [0,1,2,3,4,5,6]. 0 is Sunday. 6 is Saturday.
  # week_number: Week number of the year. The week starts on Sunday.
  ##################################################################

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
end
