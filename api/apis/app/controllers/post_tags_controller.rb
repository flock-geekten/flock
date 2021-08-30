class PostTagsController < ApplicationController
  before_action :set_post_tag, only: [:show, :update, :destroy]

  # GET /post_tags
  def index
    @post_tags = PostTag.all

    render json: @post_tags
  end

  # GET /post_tags/1
  def show
    render json: @post_tag
  end

  # POST /post_tags
  def create
    @post_tag = PostTag.new(post_tag_params)

    if @post_tag.save
      render json: @post_tag, status: :created, location: @post_tag
    else
      render json: @post_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /post_tags/1
  def update
    if @post_tag.update(post_tag_params)
      render json: @post_tag
    else
      render json: @post_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post_tags/1
  def destroy
    @post_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_tag
      @post_tag = PostTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_tag_params
      params.require(:post_tag).permit(:post_id, :tag_id)
    end
end
