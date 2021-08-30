class Api::V1::PostsApiController < ApplicationController

  def index
    # 全ての投稿を要約と共に取得する
    @posts = Post.all
    post_summary_dict = []
    for post in @posts
      summary = post.summary
      post_summary_dict << { post: post, summary: summary }
    end
    render json: post_summary_dict
  end

  def show
    @post = Post.find(params[:post_id])
    @user = @post.user
    @summary = @post.summary
    render json: { post: @post, user: @user, summary: @summary }
  end

end
