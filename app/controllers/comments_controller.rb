class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: :destroy
  before_action :load_post, :check_params_comment, :check_content_and_parent, only: :create

  def create
    @comment = @post.comments.new comment_params
    if @comment.save
      respond_to :js
    else
      flash[:danger] = t "messages.create_failed"
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
    @comment.destroy
    if @comment.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: Comment.name)
      redirect_to post_path(params[:post_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(Comment::COMMENT_PARAMS).merge(user_id: current_user.id)
  end

  def load_post
    @post = Post.find_by id: params[:post_id]

    return if @post

    flash[:danger] = t("messages.not_exists", name: @resource)
    redirect_to root_path
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment

    flash[:danger] = t("messages.not_exists", name: Comment.name)
    redirect_to root_path
  end

  def check_content_and_parent
    if params[:comment][:content].present?
      return if params[:comment][:parent_id].blank?

      @parent = Comment.find_by id: params[:comment][:parent_id]

      return if @parent
    end
    flash[:danger] = t("messages.not_exists", name: Comment.name)
    redirect_to root_path
  end

  def check_params_comment
    return if params[:comment].present?

    flash[:danger] = flash.now[:danger] = t "messages.create_failed"
    redirect_to post_path(params[:post_id])
  end
end
