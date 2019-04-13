class RepeatingRidesController < ApplicationController
  before_action :set_repeating_ride, only: [:update, :destroy]
  before_action :validate_params

  def create
    RepeatingRide.create!(repeating_rides_params)
  
    render json:{}, status: 201
  end

  def update
    @repeating_ride.update_rides(repeating_rides_params)

    render json:{}, status: 200
  end

  def destroy
    @repeating_ride.delete_all_rides

    render json:{}, status: 200
  end

  private

  def repeating_rides_params
    params.permit(
      :frequency,
      :location,
      :time,
      :user_id,
      days:[]
    )
  end

  def validate_params
    # Recurrance cannot be over 4 weeks
    if repeating_rides_params['frequency'] &&
       (repeating_rides_params['frequency'] < 0 || repeating_rides_params['frequency'] > 4)
      raise ErrorHandler::UnprocessableEntity, "Cannot repeat for more than a month"
    end
    # Days must be within 0 to 6. 0 for Sunday, 6 for Saturday.
    if repeating_rides_params['days'] &&
        (repeating_rides_params['days'] - (0..6).to_a).any?
      raise ErrorHandler::UnprocessableEntity, "Invalid day. Use 0 for Sunday, 6 for Saturday."
    end
  end

  def set_repeating_ride
    @repeating_ride = RepeatingRide.find(params['repeating_ride_id'])
  end
end
