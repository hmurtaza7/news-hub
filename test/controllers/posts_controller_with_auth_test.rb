require 'test_helper'

class PostsControllerWithAuthTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post1 = posts(:post_1)
    @post3 = posts(:post_3)
    sign_in users(:user_1), scope: :user
   end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create a new post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { title: "new post", url: "new url" } }
    end

    assert_redirected_to root_url
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post1)
    end

    assert_redirected_to root_url
  end

  test "should not destroy someone else's post" do
    assert_no_difference('Post.count', -1) do
      delete post_url(@post3)
    end

    assert_redirected_to root_url
  end
end
