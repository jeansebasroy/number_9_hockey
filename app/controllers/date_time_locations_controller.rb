class DateTimeLocationsController < ApplicationController
  before_action :signed_in_admin,  only: [:create, :edit, :update, :destroy]

  def new
    @camp = Camp.find(params[:camp_id])
    @date = DateTimeLocation.new
  end

  def create
    @camp = Camp.find(params[:camp_id])
    @date = DateTimeLocation.create(date_params)
    #@date.camp_id = params[:camp_id]
    if @date.save
      flash[:success] = "Date, Time, & Location information has been added to Camp."
      redirect_to @camp
    else
      render 'new'
    end
  end

  def edit
  	@camp = Camp.find(params[:camp_id])
  	@date = DateTimeLocation.find(params[:id])
  end

  def update
  	@camp = Camp.find(params[:camp_id])
  	@date = DateTimeLocation.find(params[:id])
    if @date.update_attributes(date_params)
      flash[:success] = "Camp Dates & Information updated."
      redirect_to @camp
    else
      render 'edit'
    end
  end

  def destroy
  	@camp = Camp.find(params[:camp_id])
  	@date = DateTimeLocation.find(params[:id])
  	@date.destroy
  	redirect_to @camp
  end

    private
      def date_params
        params.require(:date_time_location).permit(:date, :start_time, :end_time, :camp_id, :rink_id)
      end

end
