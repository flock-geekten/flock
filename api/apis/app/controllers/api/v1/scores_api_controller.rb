class Api::V1::ScoresApiController < ApplicationController

  def show
    # ユーザーに紐づいた好きなあそびを取得する
    @user = User.find(params[:user_id])
    @funs = @user.user_hangout_funs.select(:id, :hangout_id, :fun_score)
    render json: @funs
  end

  def create
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    fun_score = params[:fun_score]
    @user_hangout_score = UserHangoutFun.where(user_id: user_id, hangout_id: hangout_id)
    # 同じものが存在したら更新，存在しなければ作成
    if @user_hangout_score.empty?
      @user_hangout_score = UserHangoutFun.create(user_id: user_id, hangout_id: hangout_id, fun_score: fun_score)
    else
      @user_hangout_score.update(fun_score: fun_score)
    end
    render json: @user_hangout_score
  end

  def update
    user_id = params[:user_id]
    hangout_id = params[:hangout_id]
    fun_score = params[:fun_score]
    @user_hangout_score = UserHangoutFun.where(user_id: user_id, hangout_id: hangout_id)
    @user_hangout_score.update(fun_score: fun_score)
    render json: @user_hangout_score
  end

  def destroy
    @user_hangout_score = UserHangoutFun.where(user_id: user_id, hangout_id: hangout_id)
    @user_hangout_score.destroy
  end

end
