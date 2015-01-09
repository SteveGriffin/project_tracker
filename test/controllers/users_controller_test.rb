require "test_helper"

class UsersControllerTest < ActionController::TestCase

  def setup
    @user ||= users :one
  end

  def user
    @user ||= users :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_new
    get :new
    assert_response :success
  end

  #needs explicit email value created or else fails for some reason
  def test_create
     assert_difference('User.count') do
     @user.email = "asdfasdgfasdf@asdfasd.com"
       #post :create, user: { admin: user.admin, email: user.email, name: user.name, password: user.password_digest}
       post :create, user: {email: @user.email.to_s,password: @user.password_digest}
    end

    assert_redirected_to user_path(assigns(:user)), @response.body
  end

  def test_show
    get :show, id: user
    assert_response :success
  end

  def test_edit
    get :edit, id: user
    assert_response :success
  end

  def test_update
    put :update, id: user, user: { admin: user.admin, email: user.email, name: user.name, password_digest: user.password }
    assert_response :success #assert_redirected_to user_path(assigns(:user))
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, id: user
    end

    assert_redirected_to users_path
  end
end
