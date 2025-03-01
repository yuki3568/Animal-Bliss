class VideosController < ApplicationController
  before_action :require_login
  include VideosHelper

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
    @comment = Comment.new
    @comments = @video.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if check_short_video_url?(@video.url)
      @video.save
      redirect_to videos_path, success: t("video.create.success"), item: Video.model_name.human
    else
      flash.now[:error] = t("video.create.error")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    video = Video.find(params[:id])
    if video.user_id == current_user.id
      video.destroy!
      redirect_to videos_path, success: t("video.destroy.success", item: Video.model_name.human)
    else
      redirect_to videos_path, error: t("video.destroy.error", item: Video.model_name.human)
    end
  end

  def bookmarks
    @bookmark_videos = current_user.bookmark_videos.includes(:user).order(created_at: :desc)
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end
end
