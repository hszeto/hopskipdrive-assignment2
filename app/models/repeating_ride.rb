class RepeatingRide < ApplicationRecord
  serialize :days

  belongs_to :user

  def serialize_response
    attributes.select{ |k,v| k != 'created_at' && k != 'updated_at' }
  end
end
