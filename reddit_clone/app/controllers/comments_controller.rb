class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
    if params[:parent_comment_id]
      @comment.parent_comment_id = params[:parent_comment_id]
    end
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post)
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_url(@comment.post)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
