class RepeatingRide < ApplicationRecord
  include Generatable

  serialize :days

  belongs_to :user
  has_many :rides, dependent: :destroy

  validates_presence_of :frequency, :days, :time, :location

  def update_rides(data)
    self.update(data)
    self.rides.update(data)
  end
end
