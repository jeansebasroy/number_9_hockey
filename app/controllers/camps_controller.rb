class CampsController < ApplicationController
  before_action :signed_in_admin,  only: [:edit, :update]
 
  def new
  
  end

  private
  	def signed_in_admin
  		redirect_to(root_url) unless current_user.admin?
  	end

end
