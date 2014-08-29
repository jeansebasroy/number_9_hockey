require 'rails_helper'

describe AgeGroup do

  before { @age_group = AgeGroup.new(name: "Mite", age_start: 0, age_end: 8) }
  #let(:age_group) { FactoryGirl.create(:age_group) }

  subject { @age_group }

  it { should respond_to(:name) }
  it { should respond_to(:age_start) }
  it { should respond_to(:age_end) }
  
  it { should be_valid }
  
  describe "when name is not present" do
  	before { @age_group.name = "" }
  	it { should_not be_valid }
  end
  
  describe "when age_start is not present" do
  	before { @age_group.age_start = "" }
  	it { should_not be_valid }
  end
  
  describe "when age_start is not a number" do
  	before { @age_group.age_start = "a" }
  	it { should_not be_valid }
  end

  describe "when age_start is not an integer" do
  	before { @age_group.age_start = 10.5 }
  	it { should_not be_valid }
  end

  describe "when age_end is not present" do
  	before { @age_group.age_end = "" }
  	it { should_not be_valid }
  end

  describe "when age_end is not a number" do
  	before { @age_group.age_end = "a" }
  	it { should_not be_valid }
  end

  describe "when age_end is not an integer" do
  	before { @age_group.age_end = 10.5 }
  	it { should_not be_valid }
  end

end