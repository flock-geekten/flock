class Api::V1::TagsApiController < ApplicationController

  def index
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
    post_summary_dict = []
    for post in @posts
      summary = post.summary
      comments_count = post.comments.count
      likes_count = post.likes.count
      tags = post.tags
			flock = post.flock
      post_summary_dict << { post: post, summary: summary, comments_count: comments_count, likes_count: likes_count, tags: tags, flock: flock }
    end
    render json: { tag: @tag, posts: post_summary_dict }
  end
end
