class InvitationsController < ApplicationController
  
  def new
  	#generates a new invitation_code
  end

  def verify_invitation
  	#verify that the submitted invitation_code is valid
  		#is in database, has not expired, & has not been used
  	if 1 == 2
  		#set the use_date field in the invitations model
  		#allow user to go to signup page
  		redirect_to "/signup"
  	else
  		flash[:error] = "The Invitation Code submitted did not match our records.  Try again."
  		redirect_to "/signin"
  		#is this pointing to 'new' in the invitations_controller
  		#or 'new' for the sessions_controller?
  	end
  end
end
