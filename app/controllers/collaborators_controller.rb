class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]

  # GET /collaborators
  # GET /collaborators.json
  def index
    admin?
    @collaborators = Collaborator.all
  end

  # GET /collaborators/1
  # GET /collaborators/1.json
  def show
  end

  # GET /collaborators/new
  def new
    @collaborator = Collaborator.new
  end

  # GET /collaborators/1/edit
  def edit
  end

  # POST /collaborators
  # POST /collaborators.json
  def create
    @collaborator = Collaborator.new(collaborator_params)

    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully created.' }
        format.json { render :show, status: :created, location: @collaborator }
      else
        format.html { render :new }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaborators/1
  # PATCH/PUT /collaborators/1.json
  def update
    respond_to do |format|
      if @collaborator.update(collaborator_params)
        format.html { redirect_to @collaborator, notice: 'Collaborator was successfully updated.' }
        format.json { render :show, status: :ok, location: @collaborator }
      else
        format.html { render :edit }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1
  # DELETE /collaborators/1.json
  def destroy
    @collaborator.destroy
    respond_to do |format|
      format.html { redirect_to collaborators_url, notice: 'Collaborator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Add a collaborator by email
  def add_collaborator
    project_id = params[:project_id]
    email = params[:email]

    @user = User.find_by(email: email)

    if @user != nil
      #check if user is already a collaborator
      @existing = Collaborator.find_by(user_id: @user.id, project_id: project_id)
      if @existing != nil
        redirect_to project_url(project_id), notice: "Collaborator is already a contributor to this project"
      else
        #add user as a collaborator
        @collaborator = Collaborator.new
        @collaborator.project_id = project_id
        @collaborator.user_id = @user.id
        @collaborator.save
        redirect_to project_url(project_id), notice: "Collaborator added to project."
      end
    else
      #user not found, redirect
      redirect_to project_url(project_id), notice: "User was not found.  Collaborators must have an account to be added to the project."
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def collaborator_params
    params.require(:collaborator).permit(:user_id, :project_id)
  end
end
