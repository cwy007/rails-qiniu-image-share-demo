module ApplicationHelper
  def qiniu_image_url(post, format = :raw)
    url = "http://ozkkhjd3o.bkt.clouddn.com/#{post.qiniu_hash}"
    case format
    when :square
      url << '?imageView2/1/w/300/h/300/q/90'
    when :preview
      url << '?imageView2/2/w/1000/h/1000/q/90'
    when :raw
      url << "?attname=#{post.filename}"
    else
      url
    end
  end
end
