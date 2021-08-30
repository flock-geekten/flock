class Api::V1::UsersController < ApplicationController

  def current_user
    @user = User.where(uid: params[:uid])
    render json: @user
  end

end
