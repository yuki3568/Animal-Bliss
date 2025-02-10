class CommentsController < ApplicationController
  before_action :require_login, only: [ :create, :destroy, :edit, :update ]

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to video_path(comment.video), success: t("defaults.flash_message.created", item: Comment.model_name.human)
    else
      redirect_to video_path(comment.video), error: t("defaults.flash_message.not_created", item: Comment.model_name.human)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  def edit
    @comment = Comment.find(params[:id])
    # リクエストに対して異なるフォーマットでレスポンスを返す
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to video_path(@comment.video) }
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      respond_to do |format|
        format.turbo_stream # 更新成功時にTurbo Stream形式でレスポンスを返す
        format.html { redirect_to video_path(@comment.video) }
      end
    else
      respond_to do |format|
        format.turbo_stream # エラー時にもTurbo Streamで応答
        format.html { render :edit }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(video_id: params[:video_id])
  end
end
