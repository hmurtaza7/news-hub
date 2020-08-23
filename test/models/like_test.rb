require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "should not be able to re-like a post" do
    post = posts(:post_1)
    user = users(:user_1)

    like = Like.new(post_id: post.id, user_id: user.id)
    assert_not like.save
  end

  test "should be able to unlike a liked post" do
    post = posts(:post_1)
    user = users(:user_1)

    like = Like.find_by(post_id: post.id, user_id: user.id)
    assert like.destroy
  end

  test "should be able to like a new post" do
    post = posts(:post_1)
    user = users(:user_2)

    like = Like.new(post_id: post.id, user_id: user.id)
    assert like.save
  end

  test "should increment likes_count in post" do
    post = posts(:post_2)
    user = users(:user_2)
    old_count = post.likes_count

    like = Like.new(post_id: post.id, user_id: user.id)
    assert like.save

    post.reload
    assert_equal (old_count + 1), post.likes_count
  end

end
