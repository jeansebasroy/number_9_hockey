require 'rails_helper'

describe DateTimeLocation do

  before { @date_time_location = DateTimeLocation.new(date: "2014-08-08",
							start_time: "08:00", end_time: "10:00",
                            camp_id: 1, rink_id: 1) }

  subject { @date_time_location }

  it { should respond_to(:date) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:camp_id) }
  it { should respond_to(:rink_id) }
  
  it { should be_valid }
  
  describe "when date is not present" do
  	before { @date_time_location.date = " " }
  	it { should_not be_valid }
  end

  #describe "when date is not valid" do
  #	before { @date_time_location.date = " " }
  #	it { should_not be_valid }
  #end

  describe "when start_time is not present" do
  	before { @date_time_location.start_time = " " }
  	it { should_not be_valid }
  end

  #describe "when start_time is not valid" do
  #	before { @date_time_location.start_time = " " }
  #	it { should_not be_valid }
  #end

  describe "when end_time is not present" do
  	before { @date_time_location.end_time = " " }
  	it { should_not be_valid }
  end

  #describe "when end_time is not valid" do
  #	before { @date_time_location.end_time = " " }
  #	it { should_not be_valid }
  #end

  describe "when camp_id is not present" do
  	before { @date_time_location.camp_id = " " }
  	it { should_not be_valid }
  end

  describe "when camp_id is not a number" do
  	before { @date_time_location.camp_id = "a" }
  	it { should_not be_valid }
  end

  describe "when camp_id is not an integer" do
  	before { @date_time_location.camp_id = 10.5 }
  	it { should_not be_valid }
  end

   describe "when rink_id is not present" do
  	before { @date_time_location.rink_id = " " }
  	it { should_not be_valid }
  end

  describe "when rink_id is not a number" do
  	before { @date_time_location.rink_id = "a" }
  	it { should_not be_valid }
  end

  describe "when rink_id is not an integer" do
  	before { @date_time_location.rink_id = 10.5 }
  	it { should_not be_valid }
  end

end