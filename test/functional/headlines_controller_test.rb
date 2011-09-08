require 'test_helper'

class HeadlinesControllerTest < ActionController::TestCase
  setup do
    @headline = Headline.create!(title: "Test", content: "This is a test", created_at: 5.minutes.ago)
    @headline_two = Headline.create!(title: "Test", content: "This is a test")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:headlines)
    # TODO: Posts should be sorted in order of creation date
    assert_equal 5, assigns(:headlines).count, "There should be no more than 5 news posts per page"
  end

  test "should get new" do
    as_admin { get :new }
    assert_response :success
  end

  test "should create post" do
    assert_difference('Headline.count') do
      as_admin { post :create, headline: @headline_two.attributes }
    end

    assert_not_nil assigns(:headline)
    assert_redirected_to headline_path(assigns(:headline))
  end

  test "should show post" do
    get :show, id: @headline.to_param
    assert_response :success
  end

  test "should get edit" do
    as_admin { get :edit, id: @headline.to_param }
    assert_response :success
  end

  test "should update post" do
    as_admin { put :update, id: @headline.to_param, post: @headline.attributes }
    assert_not_nil assigns(:headline)
    assert_redirected_to headline_path(assigns(:headline))
  end

  test "should destroy post" do
    assert_difference('Headline.count', -1) do
      as_admin { delete :destroy, id: @headline.to_param }
    end

    assert_redirected_to headlines_path
  end
end
