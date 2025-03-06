class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to request.referer + "#post-#{@post.id}"
    else
      redirect_to request.referer + "#post-#{@post.id}", alert: "Erro ao adicionar comentário."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end