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
    @hangout = Hangout.create(hangout_params)
    @hangouts = Hangout.all
    render json: @hangouts
  end

  # PATCH/PUT /hangouts/1
  def update
    @hangout.update(hangout_params)
    @hangouts = Hangout.all
    render json: @hangouts
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
      params.permit(
        :name, 
        :easy_week,
        :small_group,
        :large_group,
        :indoor, 
        :outdoor, 
        :summer,
        :winter,
        :house,
        :town,
        :mountain,
        :sea,
        :nonbiri,
        :waiwai,
        :dont_move,
        :move,
        :exercise,
        :online,
        :offline,
        :to_2000yen,
        :to_4000yen,
        :to_6000yen,
        :to_8000yen,
        :to_10000yen,
        :over_10000yen,
      )
    end
end
