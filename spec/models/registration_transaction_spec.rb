require 'rails_helper'

describe RegistrationTransaction do

	before { @registration_transaction = RegistrationTransaction.new(player_camp_registration_id: 1,
											x_amount: 195,
											x_first_name: "Jean",
											x_last_name: "Beliveau",
											x_trans_id: 1,
											x_type: "auth_capture") }

	  #before { @player = Player.new(first_name: "Maurice",
		#					last_name: "Richard", 
		#					date_of_birth: "1921-08-04", 
		#					shoots: "Right") }
	
	subject { @registration_transaction }

	it { should respond_to(:player_camp_registration_id) }
  	it { should respond_to(:x_amount) }
	it { should respond_to(:x_first_name) }
  	it { should respond_to(:x_last_name) }
  	it { should respond_to(:x_trans_id) }
  	it { should respond_to(:x_type) }
 
 	it { should be_valid }

	describe "when player_camp_registration_id is not present" do
  		before { @registration_transaction.player_camp_registration_id = " " }
  		it { should_not be_valid }
  	end
  
	describe "when player_camp_registration_id is not an integer" do
  		before { @registration_transaction.player_camp_registration_id = "a" }
  		it { should_not be_valid }
  	end
  
  	describe "when x_amount is not present" do
  		before { @registration_transaction.x_amount = " " }
  		it { should_not be_valid }
  	end

	describe "when x_amount is not a number" do
  		before { @registration_transaction.x_amount = "a" }
  		it { should_not be_valid }
  	end

	describe "when x_first_name is not present" do
  		before { @registration_transaction.x_first_name = " " }
  		it { should_not be_valid }
  	end
  
  	describe "when x_last_name is not present" do
  		before { @registration_transaction.x_last_name = " " }
  		it { should_not be_valid }
  	end

	describe "when x_trans_id is not present" do
  		before { @registration_transaction.x_trans_id = " " }
  		it { should_not be_valid }
  	end

	describe "when x_type is not present" do
  		before { @registration_transaction.x_type = " " }
  		it { should_not be_valid }
  	end

end