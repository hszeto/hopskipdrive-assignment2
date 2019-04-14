class RepeatingRideSerializer < ActiveModel::Serializer
  attributes :id, :frequency, :location, :time, :days
end
