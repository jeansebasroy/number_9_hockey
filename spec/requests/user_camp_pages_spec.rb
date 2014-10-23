require 'rails_helper'

describe "User Camp pages" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:player1) { FactoryGirl.create(:player, last_name: 'Player1') }
  let!(:user_to_player1) { FactoryGirl.create(:user_to_player, 
                                                user_id: user.id, 
                                                player_id: player1.id) }

  let!(:camp1) { FactoryGirl.create(:camp, name: "Camp 1") }
  let!(:camp2) { FactoryGirl.create(:camp, name: "Camp 2") }

	subject { page }

  describe "Sign In user" do

    before { visit signin_path }

    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    it { should have_link('Sign Out') }

# => need to change to "Camp page"    
    describe "Camp page" do

      it { should have_title(user.first_name) }

      describe "without Camp invitation" do
        it { should_not have_content("Camp Invitation") }
      end

      describe "with one Camp invitation" do
        let!(:player1_camp1_invitation1) { FactoryGirl.create(:player_camp_invitations, 
                                                              player_id: player1.id,
                                                              camp_id: camp1.id) }      
        before { click_link('My Home') }

        it { should have_content("Camp Invitation:") }

        describe "view Camp" do
        
          before { click_link('View Camp Details') } 

          it { should have_title("#{camp1.name}") }
          it { should have_content("Camp Name") }
          it { should have_content("Description") }
          it { should_not have_link("Add Date") }

        end
      end

      describe "with two Camp invitations" do
        let!(:player1_camp1_invitation2) { FactoryGirl.create(:player_camp_invitations, 
                                                              player_id: player1.id,
                                                              camp_id: camp1.id) }      
        let!(:player1_camp2_invitation) { FactoryGirl.create(:player_camp_invitations, 
                                                              player_id: player1.id,
                                                              camp_id: camp2.id) }
        
        before { click_link('My Home') }

        it { should have_content("#{camp1.name}") }
# => need to adjust home page to view multiple invitations
#        it { should have_content("Camp Invitations:") }
#        it { should have_content("#{camp2.name}") }

      end   
    end
  end
end

