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
        :knowledge_rule,
        :time_to1,
        :time_from1_to2,
        :time_from2_to3,
        :time_from3,
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
        :scream,
        :dont_move,
        :move,
        :exercise,
        :online,
        :to_2000yen,
        :to_4000yen,
        :to_6000yen,
        :over_6000yen
      )
    end
end
