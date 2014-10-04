class UsersController < ApplicationController
  load_and_authorize_resource

  #before_action :signed_in_user,  only: [:edit, :update]
  #before_action :correct_user,    only: [:edit, :update]

	def show
		@user = User.find(params[:id])
    authorize! :show, @user

    # => for related Players
    # => move this to the User Model
    # => make it a single call from the controller to get this information
    @player_ids = UserToPlayer.user_has_players(@user.id)
    player_ids_array = Array.new
    @player_ids.each do |player_ids|
      player_ids_array.push(player_ids.player_id)
    end
    @players = Player.find(player_ids_array)

    # => for related Coaches
    @coach = []

	end

	def new
    @user = User.new
    authorize! :new, @user
    
    #check that an invitation_code has been submitted
    if session[:invitation_code].blank?
      flash[:notice] = "A valid Invitation Code must be submitted before Signing Up."
      #flash[:success] = "New User Invitation Code: #{invitation_code}"
      redirect_to signin_path
    else
      @user = User.new
    end   
  end

  def create
  	@user = User.new(user_params)
    authorize! :create, @user

  	if @user.save
      #sets Use Date for UserInvitation.invitation_code
      @user_invitation = UserInvitation.where(invitation_code: session[:invitation_code]).first
      @user_invitation.update(use_date: Date.today)
        #invitation.update_attributes(invite_date: Date.today, uninvite_date: nil)
        #set the use_date field in the invitations model
        #valid_code.update(use_date: Date.today)
        #this eventually should only happen if a new user account linked to this invitation_code has been successfully created

      #creates UserToPlayer relationship
      @user_to_player = UserToPlayer.create(user_id: @user.id, player_id: @user_invitation.player_id )

      #clears the invitation_code out of the session
      session[:invitation_code] = ''
  		
      sign_in @user
      flash[:success] = "Welcome to #9 Hockey!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit

  end

  def update

    if @user.update_attributes(user_params)
      flash[:success] = "User information updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def home
    @user = current_user
    authorize! :home, @user

    if @user.admin?
      redirect_to root_url
      
    else

      # => gets all the players linked to this user
        # => move to User model
      @player_ids = UserToPlayer.user_has_players(@user.id)
      player_ids_array = Array.new
      @player_ids.each do |player_ids|
        player_ids_array.push(player_ids.player_id)
      end
      @players = Player.find(player_ids_array)

      # => gets Camps to which Player has been Invited
      @invited_camps_array = PlayerCampInvitations.players_with_camp_invitations(@players)

      # => gets Camps for which Player has been Registered
      @registered_camps_array = PlayerCampRegistration.players_with_camp_registrations(@players)

      # => for related Coaches
      @coach = []

      render 'home'
    end
  end

  	private

  		def user_params
  			params.require(:user).permit(:first_name, :last_name, :email,
  										 :password, :password_confirmation)
  		end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end
end

