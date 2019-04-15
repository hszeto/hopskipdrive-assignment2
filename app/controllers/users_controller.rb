class UsersController < ApplicationController
  def index
    json_response(User.all, 200)
  end
  def create
    u = User.create!(users_params)

    json_response(u, 201)
  end

  private

  def users_params
    params.require(:user)
          .permit(
            :email,
            :name
          )
  end
end
