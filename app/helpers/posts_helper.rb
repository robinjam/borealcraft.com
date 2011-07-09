module PostsHelper
  def published_date_of(post)
    if post.updated_at < 1.day.ago
      post.updated_at.strftime "#{post.updated_at.day.ordinalize} %B %Y"
    else
      "#{time_ago_in_words post.updated_at} ago"
    end
  end
end
