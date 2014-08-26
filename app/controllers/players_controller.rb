class PlayersController < ApplicationController
  before_action :signed_in_admin, only: [:create, :edit, :update, :destroy]

  def new
  	@player = Player.new
  end


  def show
	@player = Player.find(params[:id])
   	#@dates = DateTimeLocation.where(camp_id: @camp.id)
  end

  def index
    @players = Player.all
  end

  def create
  	@player = Player.new(player_params)
  	if @player.save
  	  flash[:success] = "Player information has been saved."
  	  redirect_to @player
  	else
  	  render 'new'
  	end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @camp.update_attributes(camp_params)
      flash[:success] = "Player information updated."
      redirect_to @player
    else
      render 'edit'
    end
  end

  def invite
  	#invites the player to a camp
  	#if player not associated with a user, creates a new user invitation code
  	#if player is associated with a user, 
  	# => (1) triggers email to associated user with link to register\
  	# => (2) shows invitation on user home / sign_in page unless user registers player for camp

  end

  def uninvite
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

end
