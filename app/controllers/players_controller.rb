class PlayersController < ApplicationController
  before_action :signed_in_admin, only: [:create, :edit, :update, :destroy]

  def new
  	@player = Player.new
  	@player_evaluation = @player.player_evaluations.build
  end

  def show
	@player = Player.find(params[:id])
  @player_evaluations = PlayerEvaluation.where(player_id: @player.id)
  @camps = Camp.all
  end

  def index
    @players = Player.all
  end

  def create
  	@player = Player.new(player_params)

  	if @player.save 
  		@player_evaluation = PlayerEvaluation.create(player_evaluation_params)
  		@player_evaluation.player_id = @player.id
  		
  		if @player_evaluation.save
  	  		flash[:success] = "Player & Evaluation have been saved."
  	  		redirect_to @player

  	  	else
          render 'new'
  	  	end
  	else
      @player_evaluation = @player.player_evaluations.build
  	  render 'new'
  	end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      flash[:success] = "Player information updated."
      redirect_to @player
    else
      render 'edit'
    end
  end

  def player_invite
    #generates an invitation code for the player
    @player = Player.find(params[:player_id])
    @camp = Camp.find(params[:camp_id])
    @player_invitation = PlayerCampInvitation.create(player_invitation_params)

    if @player_invitation.save
      flash[:success] = "Player invitation code is: '12345'"
      redirect_to @player
    else
      render 'new'
    end

    #invites the player to a camp
  	#if player not associated with a user, creates a new user invitation code
  	#if player is associated with a user, 
  	# => (1) triggers email to associated user with link to register\
  	# => (2) shows invitation on user home / sign_in page unless user registers player for camp

  end

  def player_uninvite
  	#uninvites player to a camp
  	#if player is already registered for camp, will throw up an error an not allow player to be uninvited
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    flash[:success] = "Player has been deleted."
    redirect_to players_path
  end

    private
      def player_params
        params.require(:player).permit(:first_name, :last_name, :date_of_birth, :shoots)
      end
      
      def player_evaluation_params
        params.require(:player_evaluation).permit(:player_id, :evaluation_type, :league, :team, :date)
      end

      def player_invitation_params
        params.require(:player_invitation).permit(:player_id, :camp_id, :invite_date)
      end
end
