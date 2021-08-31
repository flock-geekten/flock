class Api::V1::UsersController < ApplicationController

  def current_user
    @user = User.where(uid: params[:uid]).first
    @posts = @user.posts
    @post_summary_dict = []
    for post in @posts
      summary = post.summary
      @post_summary_dict << { post: post, summary: summary }
    end
    @likes = @user.likes
    @likes_post_summary_dict = []
    for like in @likes
      post = like.post
      summary = post.summary
      @likes_post_summary_dict << { post: post, summary: summary }
    end
    @followings = @user.followings
    @followers = @user.followers
    render json: { user: @user, posts: @post_summary_dict, likes: @likes_post_summary_dict, followings: @followings, followers: @followers }
  end

end
