class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :update, :destroy]

  # GET /plans
  def index
    @plans = Plan.where(is_done: 1).order(id: "DESC")
    plans_list = []
    for plan in @plans
      plans_list << { plan: plan, comments_count: plan.plan_comments.count, participations: plan.participations.count }
    end
    # 終了していないものを取得
    render json: plans_list
  end

  # GET /plans/1
  def show
    @user = @plan.user
    @comments = @plan.plan_comments
    comments_with_users = []
    for comment in @comments
      comments_with_users << { comment: comment, user: comment.user }
    end
    @participations = @plan.participations
    participation_users = []
    for participation in @participations
      participation_users << participation.user
    end
    render json: { plan: @plan, user: @user, comments: comments_with_users, participations: participation_users }
  end

  # POST /plans
  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      render json: @plan, status: :created, location: @plan
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plans/1
  def update
    if @plan.update(plan_params)
      render json: @plan
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plans/1
  def destroy
    @plan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plan_params
      params.permit(:title, :body, :user_id, :is_done)
    end
end
