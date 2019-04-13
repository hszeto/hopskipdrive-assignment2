class RepeatingRidesController < ApplicationController
  before_action :set_repeating_ride, only: [:update, :destroy]

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

  def set_repeating_ride
    @repeating_ride = RepeatingRide.find(params['repeating_ride_id'])
  end
end
