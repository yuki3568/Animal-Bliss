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
    if @video.save
      redirect_to @video, notice: '動画が投稿されました'
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end
end
