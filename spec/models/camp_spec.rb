require 'rails_helper'

describe Camp do

	before { @camp = Camp.new(name: "Test Camp", 
								description: "This is a camp built for testing",
								publish_date: Date.today, 
								age_group: "Mite") }
	#let(:camp) { FactoryGirl.create(:camp) }

	subject { @camp }

	it { should respond_to(:name) }
 	it { should respond_to(:description) }
 	#it { should_respond_to(:publish_date) }
 	#it { should_respond_to(:age_group) }
 	
  it { should be_valid }
  	
  describe "when name is not present" do
  	before { @camp.name = " " }
  	it { should_not be_valid }
  end

  describe "when description is not present" do
  	before { @camp.description = " " }
  	it { should_not be_valid }
  end

  #describe "when publish_date is not a date" do
  #	before { @camp.publish_date = "a" }
  #	it { should_not be_valid }
  #end
  
  describe "when age_group is not present" do
  	before { @camp.age_group = " " }
  	it { should_not be_valid }
  end

  #describe "when age_group_id is not an integer" do
  #	before { @camp.age_group = 10.5 }
  #	it { should_not be_valid }
  #end

end
