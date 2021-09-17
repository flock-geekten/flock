class Api::V1::UsersController < ApplicationController

  # 現在ログインしているユーザーの情報
  def current_user
		# googleログインでユーザー登録がなされていない場合の対応
		first_flag = 0
		if User.where(uid: params[:uid]).empty?
			@user = User.create(email: params[:email], name: params[:name], uid: params[:uid])
			first_flag = 1
		end
    @user = User.where(uid: params[:uid]).first
    @posts = @user.posts
    @post_summary_dict = []
    for post in @posts
      summary = post.summary
      likes_count = post.likes.count
      comments_count = post.comments.count
			flock = post.flock
      @post_summary_dict << { post: post, summary: summary, likes_count: likes_count, comments_count: comments_count, flock: flock }
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
    render json: { user: @user, posts: @post_summary_dict, likes: @likes_post_summary_dict, followings: @followings, followers: @followers, plans: @plans, participations: participation_plan_list, first_flag: first_flag }
  end

end
