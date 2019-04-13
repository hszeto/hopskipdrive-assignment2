class RepeatingRide < ApplicationRecord
  include Generatable

  serialize :days

  belongs_to :user
  has_many :rides, dependent: :destroy

  validates_presence_of :frequency, :days, :time, :location

  def update_rides(data)
    self.rides.update(data)
  end

  def delete_all_rides
    self.rides.destroy_all
  end


  # For cleaner json response
  def selected_attributes
    attributes.select{ |k,v| k != 'created_at' && k != 'updated_at' }
  end
end
