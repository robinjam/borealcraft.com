require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = Page.create(title: 'Test page', content: 'Test content')
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post :create, page: @page.attributes
    end

    assert_redirected_to page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @page.to_param
    assert_response :success
  end

  test "should update page" do
    put :update, id: @page.to_param, page: @page.attributes
    assert_redirected_to page_path(assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page.to_param
    end

    assert_redirected_to root_path
  end
end
