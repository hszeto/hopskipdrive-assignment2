class RepeatingRidesController < ApplicationController
  def create
    RepeatingRide.create!(repeating_rides_params)
  
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
end
