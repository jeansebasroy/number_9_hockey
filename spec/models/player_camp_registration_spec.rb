require 'rails_helper'

describe PlayerCampRegistrations do

	let!(:player) { FactoryGirl.create(:player) }

    let!(:rink) { FactoryGirl.create(:rink) }
    let!(:age_group) { FactoryGirl.create(:age_group) }

    let!(:camp) { FactoryGirl.create(:camp, age_group: age_group) }

  	before { @player_camp_registration = PlayerCampRegistration.new(player_id: player.id,
							camp_id: camp.id) }

  	subject { @player_camp_registration }

  	it { should respond_to(:player_id) }
  	it { should respond_to(:camp_id) }
  	it { should respond_to(:jersey_size) }
  	it { should respond_to(:register_date) }
  	it { should respond_to(:terms_agreement) }
    
  	it { should be_valid }



end