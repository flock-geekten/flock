class Api::V1::ResultsApiController < ApplicationController

  def create
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    result = params[:result]
    @user_hangout_result = UserHangoutResult.create(user_id: user_id, hangout_id: hangout_id, result: result)
    render json: @user_hangout_result
  end

  def update
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    result = params[:result]
    @user_hangout_result = UserHangoutResult.find(params[:id])
    @user_hangout_result.update(user_id: user_id, hangout_id: hangout_id, result: result)
    render json: @user_hangout_result
  end

  def destroy
    @user_hangout_result = UserHangoutResult.find(params[:id])
    @user_hangout_result.destroy
  end

end
