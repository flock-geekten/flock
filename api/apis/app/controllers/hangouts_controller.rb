class HangoutsController < ApplicationController
  before_action :set_hangout, only: [:show, :update, :destroy]

  # GET /hangouts
  def index
    @hangouts = Hangout.all

    render json: @hangouts
  end

  # GET /hangouts/1
  def show
    render json: @hangout
  end

  # POST /hangouts
  def create
    @hangout = Hangout.new(hangout_params)

    if @hangout.save
      render json: @hangout, status: :created, location: @hangout
    else
      render json: @hangout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hangouts/1
  def update
    if @hangout.update(hangout_params)
      render json: @hangout
    else
      render json: @hangout.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hangouts/1
  def destroy
    @hangout.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hangout
      @hangout = Hangout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hangout_params
      params.require(:hangout).permit(:name)
    end
end
