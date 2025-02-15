class BookmarksController < ApplicationController
  def create
    video = Video.find(params[:video_id])
    current_user.bookmark(video)
    redirect_to videos_path, success: t('.success')
  end

  def destroy
    video = current_user.bookmarks.find(params[:id]).video
    current_user.unbookmark(video)
    redirect_to videos_path, success: t('.success'), status: :see_other
  end
end
