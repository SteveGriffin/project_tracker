require "test_helper"

class Test2sControllerTest < ActionController::TestCase

  def test2
    @test2 ||= test2s :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:test2s)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Test2.count') do
      post :create, test2: {  }
    end

    assert_redirected_to test2_path(assigns(:test2))
  end

  def test_show
    get :show, id: test2
    assert_response :success
  end

  def test_edit
    get :edit, id: test2
    assert_response :success
  end

  def test_update
    put :update, id: test2, test2: {  }
    assert_redirected_to test2_path(assigns(:test2))
  end

  def test_destroy
    assert_difference('Test2.count', -1) do
      delete :destroy, id: test2
    end

    assert_redirected_to test2s_path
  end
end
