class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.order("RAND()").limit(5)
    render json: @users
  end

  def current_user
    @user = User.where(uid: params[:uid])
    render json: @user
  end

  def show
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

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:name, :email, :uid, :age, :sex, :profile)
    end
end
