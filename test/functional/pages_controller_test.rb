require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @page = Page.create!(title: 'Test page', content: 'Test content')
  end

  test "should get new" do
    as_admin { get :new }
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      as_admin { post :create, page: { title: 'Test page', content: 'Test content' } }
    end

    assert_redirected_to page_path(assigns(:page))
  end

  test "should show page" do
    get :show, id: @page.to_param
    assert_response :success
  end

  test "should get edit" do
    as_admin { get :edit, id: @page.to_param }
    assert_response :success
  end

  test "should update page" do
    as_admin { put :update, id: @page.to_param, page: @page.attributes.slice(:title, :content) }
    assert_redirected_to page_path(assigns(:page))
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      as_admin { delete :destroy, id: @page.to_param }
    end

    assert_redirected_to root_path
  end
end
