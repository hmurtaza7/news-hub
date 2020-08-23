require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should return posts sorted by day & then by likes" do
    posts = Post.with_likes_and_user_info
    assert_operator posts[0].likes_count, :>, posts[1].likes_count
    assert_operator posts[1].created_at, :>, posts[2].created_at
    assert_equal posts[2].likes_count, posts[3].likes_count
  end

  test "should return posts with correct user & likes_count info" do
    posts = Post.with_likes_and_user_info
    assert_equal posts[0].likes_count, posts(:post_4).likes_count
    assert_equal posts[0].user_name, posts(:post_4).user.name
    assert_equal posts[4].likes_count, posts(:post_3).likes_count
    assert_equal posts[4].user_name, posts(:post_3).user.name
  end

  test "should not save post without title, url & user" do
    post = Post.new
    assert_not post.save
  end

  test "should not save post without title" do
    post = Post.new(url: 'a@a.com', user: users(:user_1))
    assert_not post.save
  end

  test "should not save post without url" do
    post = Post.new(title: 'some title', user: users(:user_1))
    assert_not post.save
  end

  test "should not save post without user" do
    post = Post.new(title: 'some title', url: 'a@a.com')
    assert_not post.save
  end

  test "should save post with title, url & user" do
    post = Post.new(title: 'some title', url: 'a@a.com', user: users(:user_1))
    assert post.save
  end
end
