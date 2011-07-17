require 'test_helper'

class NewsPostsControllerTest < ActionController::TestCase
  setup do
    @news_post = NewsPost.create!(title: "Test", content: "This is a test", created_at: 5.minutes.ago)
    @news_post_two = NewsPost.create!(title: "Test", content: "This is a test")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news_posts)
    # TODO: Posts should be sorted in order of creation date
    assert_equal 5, assigns(:news_posts).count, "There should be no more than 5 news posts per page"
  end

  test "should get new" do
    as_admin { get :new }
    assert_response :success
  end

  test "should create post" do
    assert_difference('NewsPost.count') do
      as_admin { post :create, news_post: @news_post_two.attributes }
    end

    assert_not_nil assigns(:news_post)
    assert_redirected_to news_post_path(assigns(:news_post))
  end

  test "should show post" do
    get :show, id: @news_post.to_param
    assert_response :success
  end

  test "should get edit" do
    as_admin { get :edit, id: @news_post.to_param }
    assert_response :success
  end

  test "should update post" do
    as_admin { put :update, id: @news_post.to_param, post: @news_post.attributes }
    assert_not_nil assigns(:news_post)
    assert_redirected_to news_post_path(assigns(:news_post))
  end

  test "should destroy post" do
    assert_difference('NewsPost.count', -1) do
      as_admin { delete :destroy, id: @news_post.to_param }
    end

    assert_redirected_to news_posts_path
  end
end
