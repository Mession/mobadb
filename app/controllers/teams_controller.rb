class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :set_games, only: [:new, :edit, :create]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    if current_user
      @membership = Membership.where(user_id: current_user.id, team_id: @team.id).first
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @memberships = Membership.where(team_id: @team.id)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @membership = Membership.new(user_id: current_user.id, team_leader: true, invitation_status: 1)

    respond_to do |format|
      if @team.save
        @membership.team_id = @team.id
        @membership.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :year, :location, :game_id, :max_members)
    end

    def set_games
      @games = Game.all
    end
end
