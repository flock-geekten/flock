class Api::V1::UsersController < ApplicationController

  def current_user
    @user = User.where(uid: params[:uid]).first
    @posts = @user.posts
    @post_summary_dict = []
    for post in @posts
      summary = post.summary
      likes_count = post.likes.count
      comments_count = post.comments.count
      @post_summary_dict << { post: post, summary: summary, likes_count: likes_count, comments_count: comments_count }
    end
    @likes = @user.likes
    @likes_post_summary_dict = []
    for like in @likes
      post = like.post
      likes_count = post.likes.count
      comments_count = post.comments.count
      summary = post.summary
      @likes_post_summary_dict << { post: post, summary: summary, likes_count: likes_count, comments_count: comments_count }
    end
    @followings = @user.followings
    @followers = @user.followers
    @plans = @user.plans
    @participations = @user.participations
    participation_plan_list = []
    for participation in @participations
      participation_plan_list << participation.plan
    end
    render json: { user: @user, posts: @post_summary_dict, likes: @likes_post_summary_dict, followings: @followings, followers: @followers, plans: @plans, participations: participation_plan_list }
  end

end
