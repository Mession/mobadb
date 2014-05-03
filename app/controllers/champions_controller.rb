class ChampionsController < ApplicationController
  before_action :set_champion, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:show, :heroes, :champions]

  def heroes
    @champions = Champion.where(game_id: 1).order(:name)
    @list = 'heroes'
    render :'champions/index'
  end

  def champions
    @champions = Champion.where(game_id: 2)
    @list = 'champions'
    render 'champions/index'
  end

  def show
    cr = ChampRating.where(champion_id: @champion.id, user_id: current_user).first
    if cr.nil?
      @champrating = ChampRating.new
    else
      @champrating = cr
    end
    @scores = Score.all
    @entryname = 'hero'
    if @champion.game.id == 2
      @entryname = 'champion'
    end
  end

  def new
    @champion = Champion.new
  end

  def edit

  end

  def create
    @champion = Champion.new(champion_params)

    respond_to do |format|
      if @champion.save
        format.html { redirect_to @champion, notice: 'Champion was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @champion.update(champion_params)
        format.html { redirect_to @champion, notice: 'Champion was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @champion.destroy
    respond_to do |format|
      format.html { redirect_to champions_url }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_champion
    @champion = Champion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def champion_params
    params.require(:champion).permit(:game_id, :name)
  end
end