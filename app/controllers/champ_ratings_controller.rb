class ChampRatingsController < ApplicationController
  before_action :set_champ_rating, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  def edit

  end

  def create
    @champrating = ChampRating.new(champ_rating_params)

    respond_to do |format|
      if @champrating.save
        format.html { redirect_to :back, notice: 'Rating was successfully created.' }
      elsif @champrating.update(champ_rating_params)
        format.html { redirect_to :back, notice: 'Rating was successfully updated.' }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def update
    respond_to do |format|
      if @champrating.update(champ_rating_params)
        format.html { redirect_to :back, notice: 'Rating was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @champrating.destroy
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_champ_rating
    @champrating = ChampRating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def champ_rating_params
    params.require(:champ_rating).permit(:user_id, :champion_id, :score_id, :comment, :game_id)
  end
end