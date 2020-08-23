module PostsHelper

  def like_path post_id
    link_to 'Like', post_likes_path(post_id), remote: true, method: :post
  end

  def unlike_path post_id
    link_to 'Unlike', post_likes_path(post_id), remote: true, method: :delete
  end
end
