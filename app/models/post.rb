class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :delete_all

  validates :title, presence: true, length: { maximum: 500 }
  validates :url, presence: true, length: { maximum: 2000 * 1000 }

  def self.with_likes user_id = nil
    join_query = "INNER JOIN users ON posts.user_id = users.id"
    join_query = [
      "INNER JOIN users ON posts.user_id = users.id 
        LEFT OUTER JOIN likes ON posts.id = likes.post_id AND likes.user_id = %d",
      user_id
    ] if user_id.present?

    select_query = "
        posts.id, posts.title, posts.url, posts.likes_count, posts.user_id,
        posts.created_at :: DATE AS post_date, posts.created_at,
        users.email AS user_email
      "
    select_query += ", (CASE WHEN likes.id IS NULL THEN false ELSE true END) AS liked" if user_id.present?

    self
      .joins(sanitize_sql_array(join_query))
      .select(select_query)
      .order("post_date DESC, posts.likes_count DESC")
      .distinct
  end
end
