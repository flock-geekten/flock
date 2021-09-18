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
    post_id = params[:post_id]
    tag_name = params[:tag_name]
    # タグが無い場合はタグを作成
    if Tag.where(name: tag_name).empty?
      tag = Tag.create(name: tag_name)
    else
      tag = Tag.where(name: tag_name).first
    end
    @post_tag = PostTag.create(post_id: post_id, tag_id: tag.id)
    render json: @post_tag
  end

  # PATCH/PUT /post_tags/1
  def update
    tag_name = params[:tag_name]
    # タグが無い場合はタグを作成
    if Tag.where(name: tag_name).empty?
      tag = Tag.create(name: tag_name)
    else
      tag = Tag.where(name: tag_name).first
    end
    @post_tag = @post_tag.update(tag_id: tag.id)
    render json: @post_tag
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
      params.permit(:post_id, :tag_id)
    end
end
