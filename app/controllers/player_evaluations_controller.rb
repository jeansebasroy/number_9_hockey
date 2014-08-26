class PlayerEvaluationsController < ApplicationController
  before_action :signed_in_admin,  only: [:create, :edit, :update, :destroy]

  def new
    @player = Player.find(params[:player_id])
    @player_evaluation = PlayerEvaluation.new
  end

  def create
    @player = Player.find(params[:player_id])
    @player_evaluation = PlayerEvaluation.create(player_evaluation_params)
    #@date.camp_id = params[:camp_id]
    if @player_evaluation.save
      flash[:success] = "A Player Evaluation has been added for this Player."
      redirect_to @player
    else
      render 'new'
    end
  end

  def edit
  	@player = Player.find(params[:player_id])
  	@player_evaluation = PlayerEvaluation.find(params[:id])
  end

  def update
  	@player = Player.find(params[:player_id])
  	@player_evaluation = PlayeEvaluation.find(params[:id])
    if @player_evaluation.update_attributes(player_evaluation_params)
      flash[:success] = "Player Evaluation has been updated."
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
  	@player = Player.find(params[:player_id])
  	@player_evaluation = PlayerEvaluation.find(params[:id])
  	@player_evaluation.destroy
  	redirect_to @player
  end

    private
      def player_evaluation_params
        params.require(:player_evaluation).permit(:player_id, :evaluation_type, :league, :team, :date)
      end

end
