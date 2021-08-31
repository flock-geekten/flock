class Api::V1::UsersController < ApplicationController

  def current_user
    @user = User.where(uid: params[:uid]).first
    @posts = @user.posts
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
    render json: { user: @user, posts: @posts, likes: @likes, followings: @followings, followers: @followers }
  end

end
