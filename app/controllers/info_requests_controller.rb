class InfoRequestsController < ApplicationController
  def new
  	session[:return_to] = request.referrer

    @info_request = InfoRequest.new

  end

  def create
  	@info_request = InfoRequest.new(info_request_params)

  	if @info_request.save

  	  # alerts Support Staff via email
  	  @info_request.send_info_request(@info_request)

      flash[:success] = "Info Request has been sent!"
      redirect_to session[:return_to]

  	else
  		render 'new'
  	end
  end

  	private

  		def info_request_params
  			params.require(:info_request).permit(:first_name, :last_name, :email,
  										 :message)
  		end

end
