class Api::V1::ScoresApiController < ApplicationController

  def create
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    fun_score = params[:fun_score]
    @user_hangout_score = UserHangoutFun.create(user_id: user_id, hangout_id: hangout_id, fun_score: fun_score)
    render json: @user_hangout_score
  end

  def update
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    fun_score = params[:fun_score]
    @user_hangout_score = UserHangoutFun.find(params[:id])
    @user_hangout_score.update(user_id: user_id, hangout_id: hangout_id, fun_score: fun_score)
    render json: @user_hangout_score
  end

  def destroy
    @user_hangout_score = UserHangoutFun.find(params[:id])
    @user_hangout_score.destroy
  end

end
