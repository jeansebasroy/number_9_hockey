require 'rails_helper'

describe PlayerCampRegistration do

	let!(:player) { FactoryGirl.create(:player) }

  let!(:rink) { FactoryGirl.create(:rink) }
  let!(:age_group) { FactoryGirl.create(:age_group) }

  let!(:camp) { FactoryGirl.create(:camp, age_group: age_group) }

  before { @player_camp_registration = PlayerCampRegistration.new(player_id: player.id,
							camp_id: camp.id, jersey_size: "Youth S/M", register_date: "2014-10-04", terms_agreement: "mr") }

  subject { @player_camp_registration }

  it { should respond_to(:player_id) }
  it { should respond_to(:camp_id) }
  it { should respond_to(:jersey_size) }
  it { should respond_to(:register_date) }
  it { should respond_to(:terms_agreement) }
    
  it { should be_valid }

  describe "when player_id is not present" do
    before { @player_camp_registration.player_id = " " }
    it { should_not be_valid }
  end
  
  describe "when camp_id is not present" do
    before { @player_camp_registration.camp_id = " " }
    it { should_not be_valid }
  end

  describe "when jersey_size is not present" do
    before { @player_camp_registration.jersey_size = " " }
    it { should_not be_valid }
  end

  describe "when register_date is not present" do
    before { @player_camp_registration.register_date = " " }
    it { should_not be_valid }
  end

  describe "when terms_agreement is not present" do
    before { @player_camp_registration.terms_agreement = " " }
    it { should_not be_valid }
  end

  describe "when terms_agreement is too short" do
    before { @player_camp_registration.terms_agreement = "a" }
    it { should_not be_valid }
  end
end