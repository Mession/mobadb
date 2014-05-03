class RoleRatingsController < ApplicationController
  before_action :set_role_rating, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  def index
    @role_ratings = RoleRating.all
  end

  def show

  end

  def new
    @rolerating = RoleRating.new
  end

  def edit

  end

  def create
    @rolerating = RoleRating.new(role_rating_params)

    respond_to do |format|
      if @rolerating.save
        format.html { redirect_to :back, notice: 'Role rating was successfully created.' }
      elsif @rolerating.update(role_rating_params)
        format.html { redirect_to :back, notice: 'Role rating was successfully updated.' }
      else
        format.html { redirect_to :back }
        format.json { render json: @rolerating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rolerating.update(role_rating_params)
        format.html { redirect_to :back, notice: 'Role rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rolerating.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rolerating.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role_rating
    @rolerating = RoleRating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_rating_params
    params.require(:role_rating).permit(:role_id, :user_id, :score_id, :game_id)
  end
end