class CampsController < ApplicationController
  	before_action :signed_in_admin,  only: [:edit, :update]
 
  def new
  	@camp = Camp.new
  end

  def show
	 @camp = Camp.find(params[:id])
  end

  def create
  	@camp = Camp.new(camp_params)
  	if @camp.save
  	  flash[:success] = "Camp information has been saved."
  	  redirect_to @camp
  	else
  		render 'new'
  	end
  end

  def edit
    @camp = Camp.find(params[:id])
  end

  def update
    @camp = Camp.find(params[:id])
    if @camp.update_attributes(camp_params)
      flash[:success] = "Camp information updated."
      redirect_to @camp
    else
      render 'edit'
    end
  end

  def publish
    @camp = Camp.find(params[:id])
    @camp.update(publish_date: Date.today)
    flash[:success] = "Camp information has been published."
    
    #this should point a list of all camps, sorted by most recently published
    #render 'new'
    redirect_to @camp

  end

  def unpublish
#    @camp = Camp.find(params[:id])
#    @camp.update(publish_date: nil)
  end

    private
      def camp_params
        params.require(:camp).permit(:name, :description, :publish_date)
      end

    	def signed_in_admin
  	 	 redirect_to(root_url) unless current_user.admin?
  	  end

end
