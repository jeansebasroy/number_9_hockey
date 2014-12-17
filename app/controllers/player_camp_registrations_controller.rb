class PlayerCampRegistrationsController < ApplicationController
  load_and_authorize_resource

  def new
  	#@player = Player.find_by(id: params[:player_id])
  	#@camp = Camp.find_by(id: params[:camp_id])
    #@age_group = AgeGroup.find_by(id: @camp.age_group)
    #@camp_dates_times_rinks = Camp.camp_dates_times_rinks(@camp.id)

    redirect_to paymentspayment_path({x_player_id: params[:player_id], x_camp_id: params[:camp_id]})
    #redirect_to paymentspayment_path
  end

  def create
    @user = current_user
  	@player = Player.find(params[:player_camp_registration][:player_id])
  	@camp = Camp.find(params[:player_camp_registration][:camp_id])
    @age_group = AgeGroup.find_by(id: @camp.age_group)
    @camp_dates_times_rinks = Camp.camp_dates_times_rinks(@camp.id)

    # checks to see if there's an existing registration for this player for this camp
    @player_camp_registration = PlayerCampRegistration.player_registered?(@player.id, @camp.id)

    if @player_camp_registration.nil?
      @player_camp_registration = PlayerCampRegistration.create(player_camp_registration_params)
      @player_camp_registration.register_date = Date.today

      if @player_camp_registration.save
        # marks PlayerCampInvitation as Used
        PlayerCampInvitations.invitation_used(@player.id, @camp.id)

        # sends confirmation email to user
        UserMailer.camp_registration_confirmation(@user, @player, @camp).deliver

        #flash[:success] = "#{@player.first_name} has been Registered for #{@camp.name} Camp."
        #redirect_to '/home'
        redirect_to paymentspayment_path
      else
        render 'new'
      end
    else
      # clears the Un-Register date
      @player_camp_registration.un_register_date = ''

      if @player_camp_registration.update_attributes(player_camp_registration_params)
        # marks PlayerCampInvitation as Used
        PlayerCampInvitations.invitation_used(@player.id, @camp.id)

        # sends confirmation email to user
        UserMailer.camp_registration_confirmation(@user, @player, @camp).deliver


        #flash[:success] = "#{@player.first_name} has been Registered for #{@camp.name} Camp."
        #redirect_to '/home'
        redirect_to paymentspayment_path
      else
        render 'new'
      end
    end
  end

  def edit
    @registration = PlayerCampRegistration.find(params[:id])
    @player = Player.find(@registration.player_id)
    @camp = Camp.find(@registration.camp_id)
    @age_group = AgeGroup.find_by(id: @camp.age_group)
    @camp_dates_times_rinks = Camp.camp_dates_times_rinks(@camp.id)
  end

  def update
    @player = Player.find(params[:player_camp_registration][:player_id])
    @camp = Camp.find(params[:player_camp_registration][:camp_id])
    @age_group = AgeGroup.find_by(id: @camp.age_group)
    @player_camp_registration = PlayerCampRegistration.find(params[:id])
    @camp_dates_times_rinks = Camp.camp_dates_times_rinks(@camp.id)

    if @player_camp_registration.update_attributes(player_camp_registration_params)
      flash[:success] = "Registration has been successfully updated."
      redirect_to '/home'
    else
      #flash[:error] = "What's up?"
      render 'edit'
    end
  end

  def index
   	# for admin use only
    @Registrations = PlayerCampRegistration.all
  end

  def un_register
    @registration = PlayerCampRegistration.find(params[:id])
    @player = Player.find(@registration.player_id)
    @camp = Camp.find(@registration.camp_id)

    @registration.update_attributes(un_register_date: Date.today)

# => need to notify support so that they know that someone has un-registered from a camp
    # will need to refund the money and trigger add the refund_transaction record


    # => this is a hack to get camps that have been un-registered back on the "invitation" list
    @invitation = PlayerCampInvitations.invitation_un_used(@player.id, @camp.id)

    flash[:success] = "#{@player.first_name} has been Un-Registered from #{@camp.name}."
    redirect_to '/home'
  end

  private
      def player_camp_registration_params
        params.require(:player_camp_registration).permit(:player_id, :camp_id, :jersey_size, :terms_agreement)
      end

end
