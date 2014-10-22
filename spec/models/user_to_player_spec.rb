require 'rails_helper'

describe UserToPlayer do

	before { @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar") }
	before { @user.save }

  	before { @player = Player.new(first_name: "Maurice",
							last_name: "Richard", 
							date_of_birth: "1921-08-04", 
							shoots: "Right") }
  	before { @player.save }
  	
	before { @user_to_player = UserToPlayer.new(user_id: @user.id, 
								player_id: @player.id) }

	subject { @user_to_player }

	it { should respond_to(:player_id) }
	it { should respond_to(:user_id) }
 	
	it { should be_valid }
  	
	describe "when user_id is not present" do
  		before { @user_to_player.user_id = " " }
 		it { should_not be_valid }
	end

	describe "when player_id is not present" do
  		before { @user_to_player.player_id = " " }
 		it { should_not be_valid }
	end
  
end
