class InvitationsController < ApplicationController
  
  def new_invitation
  	#generates a new invitation_code
  end

  def verify_invitation
    valid_code = Invitation.find_by(code: params[:invitations][:invitation_code])
    
    if valid_code.nil?
      flash[:error] = "The Invitation Code submitted did not match our records. Try again."
      redirect_to "/signin"

  	#checks that valid_code has not expired
    elsif valid_code.expiration_date < Date.today
      flash[:error] = "This Invitation Code has expired. Contact support@number9hockey.com if you believe there has been an error."
      redirect_to "/signin"

    #checks that valid_code has not been used
    elsif valid_code.use_date.nil? == false
      #provides notice that the invitation_code has been used
      flash[:error] = "This Invitation Code has already been used. Only one Invitation Code per person."
      redirect_to "/signin"
    
    #invitation code checks out
    else 
  		#set the use_date field in the invitations model
      valid_code.update(use_date: Date.today)
        #this eventually should only happen if a new user account linked to this invitation_code has been successfully created

   		#allow user to go to signup page
  		redirect_to "/signup"
  	
  	end
  end
end
