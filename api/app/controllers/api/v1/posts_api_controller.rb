class Api::V1::PostsApiController < ApplicationController

  def index
    @posts = Post.all
    post_summary_dict = []
    for post in @posts
      summary = post.summary
      post_summary_dict << { post: post, summary: summary }
    end
    render json: post_summary_dict
  end

end
