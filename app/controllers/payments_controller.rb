class PaymentsController < ApplicationController

  layout 'authorize_net'
  helper :authorize_net
  protect_from_forgery :except => :relay_response

  # GET
  # Displays a payment form.
  def payment2
    
    # Amount needs to be determined based on the Camp for which the User is Registering
    @amount = 10.00
    
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], 
      AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :hosted_payment_form => true)
    @sim_transaction.set_hosted_payment_receipt(AuthorizeNet::SIM::HostedReceiptPage.new(
      :link_method => AuthorizeNet::SIM::HostedReceiptPage::LinkMethod::GET, :link_text => 'Continue', 
      :link_url => payments_thank_you_url(:only_path => false)))
  end
  
  def payment
    @user = current_user
    @player = Player.find_by(id: params[:x_player_id])
    @camp = Camp.find_by(id: params[:x_camp_id])

    @age_group = AgeGroup.find_by(id: @camp.age_group)
    @camp_dates_times_rinks = Camp.camp_dates_times_rinks(@camp.id)
    @player_camp_registration = PlayerCampRegistration.new

    @amount = @camp.price
      # => for testing
      #@amount = .01
    
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], 
      AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :hosted_payment_form => true)
    @sim_transaction.set_hosted_payment_receipt(AuthorizeNet::SIM::HostedReceiptPage.new(
      :link_method => AuthorizeNet::SIM::HostedReceiptPage::LinkMethod::GET, :link_text => 'Continue', 
      :link_url => payments_thank_you_url(:only_path => false)))
  end

  # GET
  # Displays a thank you page.
  def thank_you
    @user = current_user
    @auth_code = params[:x_auth_code]
    @player = Player.find_by(id: params[:x_player_id])
    @camp = Camp.find_by(id: params[:x_camp_id])

    # checks to see if there's an existing registration for this player for this camp
    @player_camp_registration = PlayerCampRegistration.player_registered?(@player.id, @camp.id)

    if @player_camp_registration.nil?
      # creates new player_camp_registration with information passed through transaction
      @player_camp_registration = PlayerCampRegistration.new(player_id: params[:x_player_id],
                                                              camp_id: params[:x_camp_id],
                                                              jersey_size: params[:x_jersey_size],
                                                              terms_agreement: params[:x_terms_agreement],
                                                              register_date: Date.today)  


      # let's the user know that the Player has been successfully registered for the Camp
      if @player_camp_registration.save 
        # marks PlayerCampInvitation as Used
        PlayerCampInvitations.invitation_used(@player.id, @camp.id)

        # sends confirmation email to user
        UserMailer.camp_registration_confirmation(@user, @player, @camp).deliver

        # creates a record of this transaction
        @transaction = RegistrationTransaction.new(player_camp_registration_id: @player_camp_registration.id,
                                                  x_amount: params[:x_amount],
                                                  x_first_name: params[:x_first_name],
                                                  x_last_name: params[:x_last_name],
                                                  x_trans_id: params[:x_trans_id],
                                                  x_type: params[:x_type])


        if @transaction.save
          flash[:success] = "#{@player.first_name} has been successfully registered for #{@camp.name} Camp.  
                        Authorization Code: #{@auth_code}"

        else
# => need to fix this
          # notify support@number9hockey that there has been a problem

          flash[:notice] = "No Transaction.  An error has occured.  #9 Hockey will investigate, and contact you once we have resolved this issue."
        end
    
      else
# => need to fix this
        # notify support@number9hockey that there has been a problem

        flash[:notice] = "No Registration.  An error has occured.  #9 Hockey will investigate, and contact you once we have resolved this issue."
      end
      
      redirect_to '/home'

    # existing player_camp_registration record
    else
      # clears the Un-Register date
      @player_camp_registration.un_register_date = ''

      # updates exisiting player_camp_registration record
      if @player_camp_registration.update_attributes(player_id: params[:x_player_id],
                                                              camp_id: params[:x_camp_id],
                                                              jersey_size: params[:x_jersey_size],
                                                              terms_agreement: params[:x_terms_agreement],
                                                              register_date: Date.today)
        # marks PlayerCampInvitation as Used
        PlayerCampInvitations.invitation_used(@player.id, @camp.id)

        # sends confirmation email to user
        UserMailer.camp_registration_confirmation(@user, @player, @camp).deliver

        # creates a record of this transaction
        @transaction = RegistrationTransaction.new(player_camp_registration_id: @player_camp_registration.id,
                                                  x_amount: params[:x_amount],
                                                  x_first_name: params[:x_first_name],
                                                  x_last_name: params[:x_last_name],
                                                  x_trans_id: params[:x_trans_id],
                                                  x_type: params[:x_type])


        if @transaction.save
          flash[:success] = "#{@player.first_name} has been successfully registered for #{@camp.name} Camp.  
                        Authorization Code: #{@auth_code}"

        else
# => need to fix this
          # notify support@number9hockey that there has been a problem

          flash[:notice] = "No Transaction.  An error has occured.  #9 Hockey will investigate, and contact you once we have resolved this issue."
        end

        redirect_to '/home'
        
      else
        render 'new'
      end
    end
  end

end