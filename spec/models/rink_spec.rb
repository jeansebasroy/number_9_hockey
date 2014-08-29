require 'rails_helper'

describe Rink do

  before { @rink = Rink.new(name: "Johnny's Ice House", 
								address: "111 Madison",
								city: "Chicago",
								state: "IL",
								zip: "60607") }
  #let(:camp) { FactoryGirl.create(:camp) }

  subject { @rink }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }
 	 	
  it { should be_valid }
  	
  describe "when name is not present" do
  	before { @rink.name = " " }
  	it { should_not be_valid }
  end

  describe "when address is not present" do
  	before { @rink.address = " " }
  	it { should_not be_valid }
  end

  describe "when city is not present" do
  	before { @rink.city = " " }
  	it { should_not be_valid }
  end

  describe "when state is not present" do
  	before { @rink.state = " " }
  	it { should_not be_valid }
  end

  describe "when state is not in the right format" do
  	before { @rink.state = "abc" }
  	it { should_not be_valid }
  end

  #describe "when state is lower case" do
  #	before { @rink.state = "il" }
  #	it { should_not be_valid }
  #end

  describe "when state is not valid" do
  	before { @rink.state = "AB" }
  	it { should_not be_valid }
  end

  describe "when zip is not present" do
  	before { @rink.zip = " " }
  	it { should_not be_valid }
  end
  
  describe "when zip is not a number" do
  	before { @rink.zip = "abcde" }
  	it { should_not be_valid }
  end
  
  describe "when zip is not in the right format" do
  	before { @rink.zip = "123456" }
  	it { should_not be_valid }
  end

end