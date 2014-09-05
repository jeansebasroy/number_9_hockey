class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
  	if signed_in?
  		flash[:error] = "Access Denied."
  		redirect_to user_path(current_user)
  	else
  		flash[:error] = 'Access Denied.  Must be Signed In to acces.'
  		redirect_to signin
  	end
  end
end
