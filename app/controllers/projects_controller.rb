class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    admin?
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

    if authorized?
      respond_to do |format|
        format.html
        #respond to .csv format
        format.csv {send_data Project.csv(@project)}#{render text: Project.csv(@project)}
        #respond to xls format
        format.xls {send_data Project.csv(@project, col_sep: "\t") }
      end
    else
      binding.pry
      redirect_to root_url
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_collaborator
    #binding.pry
    #Project.remove_collaborator(project_id, user_id)

    @collaboration = Collaborator.find_by(project_id: params[:project_id], user_id: params[:user_id])
    @collaboration.destroy
    redirect_to dashboard_path(session[:user_id])
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #check if current user is authorized to view the project.
  #if not a project owner or collaborator, return false
  def authorized?
    #if current_user is nil, return false
    #otherwise, check for authorization
    if current_user
      authorized = false

      #if user is admin, return true
      if session[:admin] == true
        authorized = true
      else
        #puts authorized user ids in an array and check against
        #the current_user id
        authorized_users = Array.new

        authorized_users.push(@project.user_id)
        @project.collaborators.each do |col|
          authorized_users.push(col.user_id)
        end

        authorized_users.each do |user|
          # binding.pry
          if current_user.id == user
            authorized = true
          end
        end
        #authorized user not found
        if !authorized
          false
        end
      end

      #return result
      authorized
    else
      #current_user is nil, return false
      false
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :description, :completion_date, :user_id, :project_id)
  end
end
