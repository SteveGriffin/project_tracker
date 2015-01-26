class SessionsController < ApplicationController
  #skip_before_action :index
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    binding.pry
    @session = Session.new(session_params)
    @session.save

    if @session.save
      #render plain: @session.inspect
      redirect_to session_path(@session.id)
    else
     redirect_to project_path(@session.project_id), notice: 'Session not saved.  Session time may overlap with another existing session in 
     one of your projects.' 
    end
  end


  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /sessions/1
    # DELETE /sessions/1.json
    def destroy
      @session.destroy
      respond_to do |format|
        format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def stop_time(session_id = nil)
      @session = set_session
      @session.active = :false
      @session.end_time = Time.now
      @session.save!
      redirect_to session_path(stopped: true)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:project_id, :start_time, :end_time, :task_id, :active, :user_id)
    end

  end
