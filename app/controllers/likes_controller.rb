class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.new(user: current_user)

    respond_to do |format|
      if @like.save
        format.js { }
      else
        format.js { }
      end
    end
  end

  private

  def set_post
  @post = Post.find(params[:post_id])
  end
end
