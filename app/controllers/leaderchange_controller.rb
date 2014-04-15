class LeaderchangeController < ApplicationController
  before_action :set_team_id, only: [:changeleader]
  before_action :set_new_leader, only: [:changeleader]

  def set_team_id
    @team_id = params[:team_id]
  end

  def set_new_leader
    @new_leader = params[:newleader]
  end

  def changeleader
    Membership.where(user_id: current_user.id, team_id: @team_id).first.team_leader = false;
    Membership.where(user_id: @new_leader, team_id: @team_id).first.team_leader = true;
    redirect_to :back
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def leaderchange_params
    params.permit(:team_id, :newleader)
  end
end