require 'rails_helper'

describe PlayerEvaluation do

  before { @player_evaluation = PlayerEvaluation.new(player_id: 1,
							evaluation_type: "Practice", 
							league: "NHL", 
							team: "Blackhawks", 
							date: Date.today,
              jersey_number: "9",
              age_group_id: 1,
              level: "Elite F",
              notes: "Something about the player") }

  subject { @player_evaluation }

  it { should respond_to(:player_id) }
  it { should respond_to(:evaluation_type) }
  it { should respond_to(:league) }
  it { should respond_to(:team) }
  it { should respond_to(:date) }
  it { should respond_to(:jersey_number) }
  it { should respond_to(:age_group_id) }
  it { should respond_to(:level) }
  it { should respond_to(:notes) }

  it { should be_valid }
  
  describe "when player_id is not present" do
  	before { @player_evaluation.player_id = " " }
  	it { should_not be_valid }
  end


  describe "when player_id is not a number" do
  	before { @player_evaluation.player_id = "a" }
  	it { should_not be_valid }
  end

  describe "when player_id is not an integer" do
  	before { @player_evaluation.player_id = 10.5 }
  	it { should_not be_valid }
  end

  describe "when evaluation_type is not present" do
  	before { @player_evaluation.evaluation_type = " " }
  	it { should_not be_valid }
  end

  describe "when date is not present" do
  	before { @player_evaluation.date = " " }
  	it { should_not be_valid }
  end

  #describe "when date is not valid" do
  #	before { @player_evaluation.date = " " }
  #	it { should_not be_valid }
  #end

  describe "when jersey_number is not present" do
    before { @player_evaluation.jersey_number = " " }
    it { should be_valid }
  end

#  describe "when age_group is not present" do
#    before { @player_evaluation.age_group = " " }
#    it { should_not be_valid }
#  end

  describe "when level is not present" do
    before { @player_evaluation.level = " " }
    it { should be_valid }
  end

  describe "when notes is not present" do
    before { @player_evaluation.notes = " " }
    it { should be_valid }
  end

end