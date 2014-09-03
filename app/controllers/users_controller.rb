class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def new
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

