module VideosHelper
  def embed_youtube(url)
    video_id = url[/v=([^&]+)/, 1] || url.split("/").last
    "<iframe width='560' height='315' src='https://www.youtube.com/embed/#{video_id}' frameborder='0' allowfullscreen></iframe>"
  end
end
