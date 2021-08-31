class RelationshipsController < ApplicationController

  # フォローする
  def follow
    # フォローする側
    @user = User.find(params[:user_id])
    @user.follow(params[:following_id])
    render json: { is_follow: 1 }
  end

  # フォローをはずす
  def unfollow
    # フォローする 側
    p "============="
    p params[:user_id]
    p "============="
    @user = User.find(params[:user_id])
    @user.unfollow(params[:following_id])
    render json: { is_follow: 0 }
  end

  # フォローしているかをたしかめる
  def is_follow
    @user = User.find(params[:user_id])
    @target_user = User.find(params[:target_user_id])
    if @user.following?(@target_user)
      # フォローしている場合1を返す
      render json: { is_follow: 1 }
    else
      # フォローしていない場合0を返す
      render json: { is_follow: 0 }
    end
  end
end
