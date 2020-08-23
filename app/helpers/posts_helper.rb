module PostsHelper

  def like_path post_id
    link_to post_likes_path(post_id), remote: true, method: :post do
      "<i class=\"fas fa-heart\"></i>".html_safe
    end
  end

  def unlike_path post_id
    link_to post_likes_path(post_id), remote: true, method: :delete do
      "<i class=\"fas fa-heart-broken\"></i>".html_safe
    end
  end
end
