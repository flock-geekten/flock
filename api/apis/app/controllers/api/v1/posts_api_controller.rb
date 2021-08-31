class Api::V1::PostsApiController < ApplicationController

  def index
    # 全ての投稿を要約と共に取得する
    @posts = Post.order("RAND()").limit(20)
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
    @comments = @post.comments
    comments_with_users = []
    for comment in @comments
      comments_with_users << { comment: comment, user: comment.user }
    end
    render json: { post: @post, user: @user, summary: @summary, comments: comments_with_users }
  end

end
