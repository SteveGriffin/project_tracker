require "test_helper"

class CollaboratorsControllerTest < ActionController::TestCase

  def collaborator
    @collaborator ||= collaborators :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:collaborators)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Collaborator.count') do
      post :create, collaborator: { project_id: collaborator.project_id, user_id: collaborator.user_id }
    end

    assert_redirected_to collaborator_path(assigns(:collaborator))
  end

  def test_show
    get :show, id: collaborator
    assert_response :success
  end

  def test_edit
    get :edit, id: collaborator
    assert_response :success
  end

  def test_update
    put :update, id: collaborator, collaborator: { project_id: collaborator.project_id, user_id: collaborator.user_id }
    assert_redirected_to collaborator_path(assigns(:collaborator))
  end

  def test_destroy
    assert_difference('Collaborator.count', -1) do
      delete :destroy, id: collaborator
    end

    assert_redirected_to collaborators_path
  end
end
