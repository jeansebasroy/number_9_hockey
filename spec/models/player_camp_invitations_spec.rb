require 'rails_helper'

describe PlayerCampInvitations do

  before { @player_camp_invitation = PlayerCampInvitations.new(player_id: 1,
							camp_id: 2, 
							invite_date: "2014-08-04", 
							uninvite_date: "2014-08-04") }

  subject { @player_camp_invitation }

  it { should respond_to(:player_id) }
  it { should respond_to(:camp_id) }
  it { should respond_to(:invite_date) }
  it { should respond_to(:uninvite_date) }
    
  it { should be_valid }

  describe "when player_id is not present" do
  	before { @player_camp_invitation.player_id = " " }
  	it { should_not be_valid }
  end
  
  describe "when player_id is not an integer" do
  	before { @player_camp_invitation.player_id = "a" }
  	it { should_not be_valid }
  end

  describe "when camp_id is not present" do
  	before { @player_camp_invitation.camp_id = " " }
  	it { should_not be_valid }
  end
  
  describe "when camp_id is not an integer" do
  	before { @player_camp_invitation.camp_id = "a" }
  	it { should_not be_valid }
  end

  describe "when invite_date is not present" do
  	before { @player_camp_invitation.invite_date = " " }
  	it { should_not be_valid }
  end

end
