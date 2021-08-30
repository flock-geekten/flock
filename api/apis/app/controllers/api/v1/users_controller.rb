class Api::V1::UsersController < ApplicationController

  def current_user
    @user = User.where(uid: params[:uid]).first
    @posts = @user.posts
    @likes = @user.likes
    render json: { user: @user, posts: @posts, likes: @likes }
  end

end
