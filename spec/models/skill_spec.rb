require 'rails_helper'

describe Skill do

  before { @skill = Skill.new(name: "Forward Stride", 
								tool_tip: "Forward push with skates on ice",
								skill_type: "Skating",
								order: 101,
								active: true) }
  #let(:camp) { FactoryGirl.create(:camp) }

  subject { @skill }

  it { should respond_to(:name) }
  it { should respond_to(:tool_tip) }
  it { should respond_to(:skill_type) }
  it { should respond_to(:order) }
  it { should respond_to(:active) }
 	 	
  it { should be_valid }
  	
  describe "when name is not present" do
  	before { @skill.name = " " }
  	it { should_not be_valid }
  end

  describe "when tool_tip is not present" do
  	before { @skill.tool_tip = " " }
  	it { should_not be_valid }
  end

  describe "when skill_type is not present" do
  	before { @skill.skill_type = " " }
  	it { should_not be_valid }
  end

  describe "when order is not present" do
  	before { @skill.order = " " }
  	it { should_not be_valid }
  end

  describe "when order is not a number" do
  	before { @skill.order = "a" }
  	it { should_not be_valid }
  end

  describe "when order is not an integer" do
  	before { @skill.order = 10.5 }
  	it { should_not be_valid }
  end
  
end