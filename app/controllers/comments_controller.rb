class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to video_path(comment.video), success: t('defaults.flash_message.created', item: Comment.model_name.human)
    else
      redirect_to video_path(comment.video), danger: t('defaults.flash_message.not_created', item: Comment.model_name.human)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(video_id: params[:video_id])
  end
end
