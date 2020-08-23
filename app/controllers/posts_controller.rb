class PostsController < ApplicationController
  load_and_authorize_resource

  # GET /posts
  def index
    @posts = @posts.with_likes(current_user.try(:id)).page(params[:page]).per(50)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to root_url, notice: 'Successfully posted.'
    else
      render :new
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Deleted.'
  end

  private
    def post_params
      params.require(:post).permit(:title, :url)
    end
end
