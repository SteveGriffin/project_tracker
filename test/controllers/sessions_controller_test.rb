require "test_helper"

class SessionsControllerTest < ActionController::TestCase

  def session
    @session ||= sessions :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sessions)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Session.count') do
      post :create, session: { end_time: session.end_time, project_id: session.project_id, start_time: session.start_time, task_id: session.task_id }
    end

    assert_redirected_to session_path(assigns(:session))
  end

  def test_show
    get :show, id: session
    assert_response :success
  end

  def test_edit
    get :edit, id: session
    assert_response :success
  end

  def test_update
    put :update, id: session, session: { end_time: session.end_time, project_id: session.project_id, start_time: session.start_time, task_id: session.task_id }
    assert_redirected_to session_path(assigns(:session))
  end

  def test_destroy
    assert_difference('Session.count', -1) do
      delete :destroy, id: session
    end

    assert_redirected_to sessions_path
  end
end
