class InvitationsController < ApplicationController
  
  def new
  	#generates a new invitation_code
  end

  def verify_invitation
    valid_code = Invitation.find_by(code: params[:invitations][:invitation_code])
    #need to verify that the code has not expired & has not been used before
  	if  valid_code
  		#set the use_date field in the invitations model
  		#allow user to go to signup page
  		redirect_to "/signup"
  	else
  		flash[:error] = "The Invitation Code submitted did not match our records.  Try again."
  		redirect_to "/signin"

  	end
  end
end
