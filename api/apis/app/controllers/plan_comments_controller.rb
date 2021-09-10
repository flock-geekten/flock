class PlanCommentsController < ApplicationController
  before_action :set_plan_comment, only: [:show, :update, :destroy]

  # GET /plan_comments
  def index
    @plan_comments = PlanComment.all

    render json: @plan_comments
  end

  # GET /plan_comments/1
  def show
    render json: @plan_comment
  end

  # POST /plan_comments
  def create
    @plan_comment = PlanComment.new(plan_comment_params)

    if @plan_comment.save
      render json: @plan_comment, status: :created, location: @plan_comment
    else
      render json: @plan_comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plan_comments/1
  def update
    if @plan_comment.update(plan_comment_params)
      render json: @plan_comment
    else
      render json: @plan_comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plan_comments/1
  def destroy
    @plan_comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan_comment
      @plan_comment = PlanComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plan_comment_params
      params.permit(:body, :plan_id, :user_id)
    end
end
