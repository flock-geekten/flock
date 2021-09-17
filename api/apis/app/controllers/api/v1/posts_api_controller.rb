class Api::V1::PostsApiController < ApplicationController

  def index
    # 全ての投稿を要約と共に取得する
    @posts = Post.order("RAND()").limit(8)
    post_summary_dict = []
    for post in @posts
      summary = post.summary
      comments_count = post.comments.count
      likes_count = post.likes.count
      tags = post.tags
			flock = post.flock
      post_summary_dict << { post: post, summary: summary, comments_count: comments_count, likes_count: likes_count, tags: tags, flock: flock }
    end
    render json: post_summary_dict
  end

  def show
    @post = Post.find(params[:post_id])
    @user = @post.user
    @summary = @post.summary
    @comments = @post.comments
		@flock = @post.flock
    comments_with_users = []
    for comment in @comments
      comments_with_users << { comment: comment, user: comment.user }
    end
    @tags = @post.tags
    render json: { post: @post, user: @user, summary: @summary, comments: comments_with_users, tags: @tags, flock: @flock }
  end

	def add_flock
		@post = Post.find(params[:post_id])
		flock = @post.flock + 1
		p flock
		@post.update(flock: flock)
		render json: @post
	end

end
