class RepeatingRidesController < ApplicationController
  before_action :set_repeating_ride, only: [:update, :destroy]
  before_action :set_specific_ride, only: [:edit_ride, :destroy_ride]

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

  def edit_ride
    @specific_ride.update_ride(repeating_rides_params)

    render json:{}, status: 200
  end

  def destroy_ride
    @specific_ride.delete_ride

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

  def set_specific_ride
    @specific_ride = set_repeating_ride.rides.find(params['ride_id'])
  end
end
