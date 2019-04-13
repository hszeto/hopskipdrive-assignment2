class RidesController < ApplicationController
  before_action :set_ride, only: [:update, :destroy]

  def update
    @ride.update(rides_params)

    render json:{}, status: 200
  end

  def destroy
    @ride.destroy

    render json:{}, status: 200
  end

  private

  def rides_params
    params.permit(
      :location,
      :time
    )
  end

  def set_ride
    @ride = Ride.find(params['ride_id'])
  end
end