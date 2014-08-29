require 'rails_helper'

describe Player do

  before { @player = Player.new(first_name: "Maurice",
							last_name: "Richard", 
							date_of_birth: "1921-08-04", 
							shoots: "Right") }

  subject { @player }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:shoots) }
    
  it { should be_valid }

  describe "when first_name is not present" do
  	before { @player.first_name = " " }
  	it { should be_valid }
  end
  
  describe "when last_name is not present" do
  	before { @player.last_name = " " }
  	it { should_not be_valid }
  end

  describe "when date_of_birth is not present" do
  	before { @player.date_of_birth = " " }
  	it { should be_valid }
  end

  #describe "when date_of_birth is not valid" do
  #	before { @player.date_of_birth = " " }
  #	it { should_not be_valid }
  #end

  describe "when shoots is not present" do
  	before { @player.shoots = " " }
  	it { should_not be_valid }
  end

end