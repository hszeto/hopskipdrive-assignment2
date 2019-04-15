module ResponseHandler
  extend ActiveSupport::Concern

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_repeating_ride_response(status = :ok)
    render json: selected_attributes_for_repeating_ride, status: status
  end

  def selected_attributes_for_repeating_ride
    @repeating_ride.to_json(
      only: [:id, :frequency, :location, :time, :days],
      include: [
        user: {
          only:[:email]
        },
        rides: {
          only:[:date, :time, :location]
        }
      ]
    )
  end
end