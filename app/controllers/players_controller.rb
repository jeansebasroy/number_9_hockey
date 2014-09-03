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
    @player = Player.find_by(id: params[:players][:player_id])
    @camp = Camp.find_by(id: params[:players][:camp_id])

    #checks to see if Player has an associated User
    @user = UserToPlayer.player_has_user(@player.id)

    #checks to see if Player is invited
    if PlayerCampInvitations.invited(@player.id, @camp.id) == 'invited'
      #if player is invited, un-invited player
      @un_invite = PlayerCampInvitations.un_invite(@player.id, @camp.id)
            flash[:success] = 'Player has been Un-Invited.'
      redirect_to @player
    else
      #if player is not invited, invites player
      @invite = PlayerCampInvitations.invite(@player.id, @camp.id)

      if @user.empty? 
        #if no user is associated, then generates User invitation_ code
        invitation_code = UserInvitation.invitation_code_for_player(@player.id)

        flash[:success] = "New User Invitation Code: #{invitation_code}"
        redirect_to @player

      else
# => generate email for user(s) to alert them of the invitation to the camp 
        flash[:success] = 'Player has been Invited.'
        redirect_to @player
      end

    end

    #invites the player to a camp
  	#if player not associated with a user, creates a new user invitation code
  	#if player is associated with a user, 
  	# => (1) triggers email to associated user with link to register\
  	# => (2) shows invitation on user home / sign_in page unless user registers player for camp

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
