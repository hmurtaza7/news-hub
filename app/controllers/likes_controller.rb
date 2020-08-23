class LikesController < ApplicationController
  load_and_authorize_resource :post
  authorize_resource

  # POST /posts/1/likes
  def create
    @like = @post.likes.new(user_id: current_user.id)

    if @like.save
      render 'liked'
    else
      render 'error'
    end
  end

  # DELETE /posts/1/
  def destroy
    @like = @post.likes.find_by(user_id: current_user.id)
    @like.destroy if @like.present?
    render 'unliked'
  end

end
