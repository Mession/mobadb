class MembershipsController < ApplicationController
  before_action :set_membership, only: [:destroy]
  before_action :ensure_that_signed_in


  # tarkistuksia tanne etta oikea user muuttelee vain omia membershippejaan, esimerkkimetodi laitettu application_controlleriin

  def accept
    membership = Membership.find(params[:id])
    membership.update_attribute :invitation_status, 1
    redirect_to :back, notice: "Invitation accepted!"
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.team, notice: 'Invitation was successfully sent.' }
        format.json { render action: 'show', status: :created, location: @membership }
      else
        format.html { redirect_to user_path(membership_params[:user_id]), alert: 'Membership or invitation already exists!' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    invitation_status = @membership.invitation_status
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: "Membership was destroyed successfully." } if invitation_status == 1
      format.html { redirect_to :back, notice: "Invitation was declined successfully." } if invitation_status == 2
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:team_id, :user_id, :team_leader, :invitation_status)
    end
end
