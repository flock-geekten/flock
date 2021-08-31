class LikesController < ApplicationController
  
  # いいねする
  def create
    @like = Like.new(user_id: params[:user_id], post_id: params[:post_id])
    @like.save
    render json: { is_like: 1 }
  end

  # いいねをはずす
  def destroy
    @like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    @like.destroy
    render json: { is_like: 0 }
  end

  # いいねをしているかをたしかめる
  def is_likes
    @user = User.find(params[:user_id])
    if !@user.likes.find_by(post_id: params[:post_id]).nil?
      # いいねをしている場合1を返す
      render json: { is_like: 1 }
    else
      # いいねをしていない場合0を返す
      render json: { is_like: 0 }
    end
  end
end
