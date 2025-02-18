class BookmarksController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    current_user.bookmark(@video)
    flash.now[:success] = t(".success")
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @video = current_user.bookmarks.find(params[:id]).video
    current_user.unbookmark(@video)
    flash.now[:success] = t(".success")
    respond_to do |format|
      format.turbo_stream
    end
  end
end
