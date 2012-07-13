require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = Category.create!(title: "Test Category")
  end
  
  test "should get new" do
    as_admin { get :new }
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      as_admin { post :create, category: FactoryGirl.attributes_for(:category) }
    end

    assert_not_nil assigns(:category)
    assert_redirected_to forums_path
  end

  test "should get edit" do
    as_admin { get :edit, id: @category.to_param }
    assert_response :success
  end

  test "should update category" do
    as_admin { put :update, id: @category.to_param, post: @category.attributes }
    assert_not_nil assigns(:category)
    assert_redirected_to forums_path
  end

  test "should get delete" do
    as_admin { get :delete, id: @category.to_param }
    assert_response :success
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      as_admin { delete :destroy, id: @category.to_param }
    end

    assert_redirected_to forums_path
  end
end
