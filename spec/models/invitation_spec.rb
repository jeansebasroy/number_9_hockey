require 'rails_helper'

describe Invitation do

  before { @invitation = Invitation.new(code: "test_code",
							player_id: 1, coach_id: 1, 
							expiration_date: "2014-08-08", 
							use_date: "2014-08-08") }

  subject { @invitation }

  it { should respond_to(:code) }
  it { should respond_to(:player_id) }
  it { should respond_to(:coach_id) }
  it { should respond_to(:expiration_date) }
  it { should respond_to(:use_date) }
  
  it { should be_valid }
  
  describe "when code is not present" do
  	before { @invitation.code = " " }
  	it { should_not be_valid }
  end

# => validate that either player_id, coach_id, or both are present

  describe "when player_id is not a number" do
  	before { @invitation.player_id = "a" }
  	it { should_not be_valid }
  end

  describe "when player_id is not an integer" do
  	before { @invitation.player_id = 10.5 }
  	it { should_not be_valid }
  end

  describe "when coach_id is not a number" do
  	before { @invitation.coach_id = "a" }
  	it { should_not be_valid }
  end

  describe "when coach_id is not an integer" do
  	before { @invitation.coach_id = 10.5 }
  	it { should_not be_valid }
  end

  describe "when expiration_date is not present" do
  	before { @invitation.expiration_date = " " }
  	it { should_not be_valid }
  end

  #describe "when expiration_date is not valid" do
  #	before { @invitation.expiration_date = " " }
  #	it { should_not be_valid }
  #end

  #describe "when use_date is not valid" do
  #	before { @invitation.use_date = " " }
  #	it { should_not be_valid }
  #end

end