require 'rails_helper'

describe UserInvitation do

  before { @user_invitation = UserInvitation.new(invitation_code: "12345678",
							player_id: 1, coach_id: 1, 
							expiration_date: "2014-09-03", use_date: "2014-09-03") }

  subject { @user_invitation }

  it { should respond_to(:invitation_code) }
  it { should respond_to(:player_id) }
  it { should respond_to(:coach_id) }
  it { should respond_to(:expiration_date) }
  it { should respond_to(:use_date) }
  
  it { should be_valid }
  
  describe "when invitation_code is not present" do
  	before { @user_invitation.invitation_code = " " }
  	it { should_not be_valid }
  end

  describe "when invitation_code is too short" do
  	before { @user_invitation.invitation_code = "a" * 7 }
  	it { should_not be_valid }
  end
  
  describe "when player_id is not present" do
  	before { @user_invitation.player_id = " " }
  	it { should_not be_valid }
  end

  describe "when expiration_date is not present" do
  	before { @user_invitation.expiration_date = " " }
  	it { should_not be_valid }
  end

end
