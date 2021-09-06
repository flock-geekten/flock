class LikesController < ApplicationController
  
  # いいねする
  def create
    @like = Like.new(user_id: params[:user_id], post_id: params[:post_id])
    @like.save
    likes_count = Post.find(params[:post_id]).likes.count
    render json: { is_like: 1, likes_count: likes_count }
  end

  # いいねをはずす
  def destroy
    @like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    @like.destroy
    likes_count = Post.find(params[:post_id]).likes.count
    render json: { is_like: 0, likes_count: likes_count }
  end

  # いいねをしているかをたしかめる
  def is_likes
    @user = User.find(params[:user_id])
    likes_count = Post.find(params[:post_id]).likes.count
    if !@user.likes.find_by(post_id: params[:post_id]).nil?
      # いいねをしている場合1を返す
      render json: { is_like: 1, likes_count: likes_count }
    else
      # いいねをしていない場合0を返す
      render json: { is_like: 0, likes_count: likes_count }
    end
  end
end
