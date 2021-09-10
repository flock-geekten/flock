class ParticipationsController < ApplicationController

  # 参加する
  def create
    @participation = Participation.create(user_id: params[:user_id], plan_id: params[:plan_id])
    participation_count = Plan.find(params[:plan_id]).participations.count
    render json: { is_participation: 1, participations_count: participation_count }
  end

  # 参加をはずす
  def destroy
    @participation = Participation.find_by(user_id: params[:user_id], plan_id: params[:plan_id])
    @participation.destroy
    participation_count = Plan.find(params[:plan_id]).participations.count
    render json: { is_participation: 0, participations_count: participation_count }
  end

  # 参加をしているかをたしかめる
  def is_participations
    @user = User.find(params[:user_id])
    participation_count = Plan.find(params[:plan_id]).participations.count
    if !@user.participations.find_by(plan_id: params[:plan_id]).nil?
      # いいねをしている場合1を返す
      render json: { is_participation: 1, participations_count: participation_count }
    else
      # いいねをしていない場合0を返す
      render json: { is_participation: 0, participations_count: participation_count }
    end
  end

end
