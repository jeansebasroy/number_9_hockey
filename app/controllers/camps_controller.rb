class CampsController < ApplicationController
  before_action :signed_in_admin, only: [:create, :edit, :update, :destroy]
  before_action :signed_in_user,  only: [:show]

  def new
  	@camp = Camp.new
  end

  def show
	 @camp = Camp.find(params[:id])
   @dates = DateTimeLocation.where(camp_id: @camp.id)
  end

  def index
    @camps = Camp.all
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

# => show error message if no dates, times & locations are linked to this camp
    if 1 == 2 
      flash[:success] = "Camp has no dates associated to it.  Please add dates before Publishing."
      render 'show'
    else    
      flash[:success] = "Camp information has been Published."
    
      #this should point a list of all camps, sorted by most recently published
      redirect_to @camp
    end

  end

  def unpublish
    @camp = Camp.find(params[:id])
    @camp.update(publish_date: nil)

# => check to see if players or coaches have registered for this camp.
# => if they have registered, need to "unregister" them before Un-Publishing
    if 1 == 2
      flash[:error] = "Camp has registered Players & Coaches.  They need to be made aware that the Camp is being cancelled."
      #redirect to a page showing all registered players & coaches for this camp
    else
      flash[:success] = "Camp information has been Un-Published."

      #this should point a list of all camps, sorted by most recently published
      redirect_to @camp
    end

  end

  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy
    flash[:success] = "Camp has been deleted."
    redirect_to camps_path
  end

    private
      def camp_params
        params.require(:camp).permit(:name, :description, :publish_date, :age_group)
      end

end
