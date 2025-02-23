module VideosHelper
  def embed_youtube(url)
    # 通常のURLから埋め込み用URLに変換する
    # 例: https://www.youtube.com/watch?v=動画ID => https://www.youtube.com/embed/動画ID
    video_id = url[/v=([^&]+)/, 1] || url.split("/").last
    "<iframe width='560' height='315' src='https://www.youtube.com/embed/#{video_id}' frameborder='0' allowfullscreen></iframe>"
  end

  def check_short_video_url?(url)
    # YouTubeのショート動画のURL、共有URLの形式をチェックする正規表現
    # 例: https://www.youtube.com/shorts/動画ID
    regex = /\Ahttps?:\/\/(www\.)?youtube\.com\/shorts\/[a-zA-Z0-9_-]{11}(\?si=[a-zA-Z0-9_-]+)?\z/
    regex.match?(url)
  end
end
