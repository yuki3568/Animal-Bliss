class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      redirect_to videos_path, success: "動画が投稿されました"
    else
      flash.now[:error] = "動画投稿が失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    video = Video.find(params[:id])
    if video.user_id == current_user.id
      video.destroy!
      redirect_to videos_path, success: "動画を削除しました"
    else
      redirect_to videos_path, error: "削除権限がありません"
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end
end
