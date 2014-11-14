class SupportRequestsController < ApplicationController
  #load_and_authorize_resource

  def new
  	session[:return_to] = request.referrer

    @support_request = SupportRequest.new

  end

  def create
  	@support_request = SupportRequest.new(support_request_params)
    #authorize! :create, @support_request

  	if @support_request.save

  	  # alerts Support Staff via email
	    @support_request.send_support_request(@support_request)

      flash[:success] = "Support Request has been sent!"
      redirect_to session[:return_to]

  	else
  		render 'new'
  	end
  end

  	private

  		def support_request_params
  			params.require(:support_request).permit(:first_name, :last_name, :email,
  										 :message)
  		end

end
