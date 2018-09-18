class PostsController < ApplicationController
  
  before_action :require_user
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post
      if @post.update(post_params)
        redirect_to post_url(@post)
      else
        flash.now[:errors] = @post.errors.full_messages
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.author_id = current_user.id
      @post.destroy
      redirect_to sub_url(@post.sub_id)
    else
      redirect_to sub_url(@post.sub_id)
    end
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      params[:post][:sub_ids].each do |sub_id|
        PostSub.create!(post_id: @post.id, sub_id: sub_id)
      end
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render 'new'
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end
end
