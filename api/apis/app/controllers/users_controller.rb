class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def current_user
    @user = User.where(uid: params[:uid])
    render json: @user
  end

  def show
    @posts = @user.posts
    @likes = @user.likes
    @followings = @user.followings
    @followers = @user.followers
    render json: { user: @user, posts: @posts, likes: @likes, followings: @followings, followers: @followers }
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
      params.permit(:name, :email, :uid)
    end
end
