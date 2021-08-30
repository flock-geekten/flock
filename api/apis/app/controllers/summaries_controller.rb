class SummariesController < ApplicationController
  before_action :set_summary, only: [:show, :update, :destroy]

  # GET /summaries/1
  def show
    @summary = Summary.where(post_id: params[:post_id])
    render json: @summary
  end

  # POST /summaries
  def create
    @summary = Summary.new(summary_params)

    if @summary.save
      render json: @summary
      # render json: @summary, status: :created, location: @summary
    else
      render json: @summary.errors
      # render json: @summary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /summaries/1
  def update
    if @summary.update(summary_params)
      render json: @summary
    else
      render json: @summary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /summaries/1
  def destroy
    @summary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summary
      @summary = Summary.where(post_id: params[:post_id])
      # @summary = Summary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def summary_params
      params.permit(:content, :post_id)
    end
end
