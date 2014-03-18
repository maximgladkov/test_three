class UsersController < ApplicationController
  
  respond_to :json

  def authorize
    user = User.find_by_email(user_params[:email])

    if user && user.authorizable?(user_params)
      render json: user.to_json
    else
      head :unauthorized
    end
  end

  private

  def user_params
    JSON.parse request.body.read, symbolize_names: true
  end

end
