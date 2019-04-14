class RepeatingRidesController < ApplicationController
  before_action :set_repeating_ride, only: [:show, :update, :destroy]
  before_action :validate_params, except: [:show, :destroy]

  def show
    json_repeating_ride_response 
  end

  def create
    @repeating_ride = RepeatingRide.create!(repeating_rides_params)

    json_repeating_ride_response(201)
  end

  def update
    @repeating_ride.update_rides(repeating_rides_params)

    json_repeating_ride_response
  end

  def destroy
    @repeating_ride.destroy

    json_response({})
  end

  private

  def repeating_rides_params
    params.require(:repeating_ride)
          .permit(
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
