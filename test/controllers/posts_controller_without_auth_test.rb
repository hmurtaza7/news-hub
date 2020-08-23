require 'test_helper'

class PostsControllerWithoutAuthTest < ActionDispatch::IntegrationTest

  setup do
    @post = posts(:post_1)
   end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should not get new" do
    get new_post_url
    assert_redirected_to root_url
  end

  test "should not create a new post" do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { title: "new post", url: "new url" } }
    end

    assert_redirected_to root_url
  end

  test "should not destroy post" do
    assert_no_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to root_url
  end
end
