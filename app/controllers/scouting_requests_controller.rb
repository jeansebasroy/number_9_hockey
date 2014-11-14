class ScoutingRequestsController < ApplicationController
  
  def new
  	session[:return_to] = request.referrer

    @scouting_request = ScoutingRequest.new

  end

  def create
  	@scouting_request = ScoutingRequest.new(scouting_request_params)

  	if @scouting_request.save

  	  # alerts Support Staff via email
	    @scouting_request.send_scouting_request(@scouting_request)

      flash[:success] = "Scouting Request has been sent!"
      redirect_to session[:return_to]

  	else
  		render 'new'
  	end
  end

  	private

  		def scouting_request_params
  			params.require(:scouting_request).permit(:first_name, :last_name, :email,
  										 :message)
  		end

end
