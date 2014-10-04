require 'rails_helper'

describe "Player Camp Registration pages" do

  let!(:user) { FactoryGirl.create(:user) }
  
  let!(:player) { FactoryGirl.create(:player) }
  let!(:user_to_player) { FactoryGirl.create(:user_to_player, 
                                              user_id: user.id,
                                              player_id: player.id) }

  let!(:rink) { FactoryGirl.create(:rink) }
  let!(:age_group) { FactoryGirl.create(:age_group) }
  let!(:camp1) { FactoryGirl.create(:camp, age_group: age_group) }

  let!(:player_camp1_invitation) { FactoryGirl.create(:player_camp_invitations, 
                                                        player_id: player.id,
                                                        camp_id: camp1.id) }  
  subject { page }
  
  describe "Sign In user" do

    before { visit signin_path }

    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    describe "Register" do
      
      before { click_link 'Register' }

      it { should have_title "Register" }
      it { should have_button 'Register' }

      describe "with invalid information" do

# => fix this
#        it "should not create a Registration" do
#          expect { click_button "Submit Registration" }.not_to change(Camp Registration, :count)
#        end

        before { click_button 'Register' }

        it { should have_selector('div.alert.alert-error') }
        it { should have_title("Register") }

      end

      describe "with valid information" do

        before do
          select 'Youth S/M',   from: 'player_camp_registration[jersey_size]'
            
          fill_in "Initial:",   with: "rm"
        end

# => fix this
#          it "should not create a Registration" do
#            expect { click_button "Submit Registration" }.not_to change(Camp Registration, :count)
#          end

        before { click_button 'Register' }

        it { should have_selector('div.alert.alert-success') }
        it { should have_title "Home of #{user.first_name}" }
        it { should_not have_title 'Register' }

# => is 'true because 'Un-Register' contains 'Register'
        #it { should_not have_link 'Register' }
        it { should have_link 'Update' }
        it { should have_link 'Un-Register' }

        it { should_not have_content 'Camp Invitation:' }
        it { should have_content 'Camp Registration:' }

      end
    end

    describe "update Registration" do
      # => need to create registration to 'Update' from
      let!(:camp2) { FactoryGirl.create(:camp, age_group: age_group) }
      let!(:player_camp2_registration) { FactoryGirl.create(:player_camp_registration, 
                                                              player_id: player.id,
                                                              camp_id: camp2.id) } 
      before { click_link "My Home" }

      it { should_not have_content 'Camp Invitation:' }
      it { should have_content 'Camp Registration' }

      before { click_link "Update Registration" }

      it { should have_title "Update Registration" }

      describe "with invalid information" do

        before { click_button "Update" }

        it { should have_selector('div.alert.alert-error') }
        it { should have_title("Update Registration") }

# => fix this
#          it "should not create a Registration" do
#            expect { click_button "Submit Registration" }.not_to change(Camp Registration, :count)
#          end
      end

      describe "with valid information" do
        before do
          select 'Youth L/XL',   from: 'player_camp_registration[jersey_size]'
            
          fill_in "Initial:",   with: "rm"
        end

# => fix this
#        it "should not create a Registration" do
#          expect { click_button "Submit Registration" }.not_to change(Camp Registration, :count)
#        end

        before { click_button 'Update' }

        it { should have_selector('div.alert.alert-success') }
        it { should have_title "Home of #{user.first_name}" }
        it { should_not have_title 'Register' }

      end
    end

    describe "Un-Register" do
      # => need to create registration to 'Un-Register' from
      let!(:camp3) { FactoryGirl.create(:camp, age_group: age_group) }
      let!(:player_camp3_registration) { FactoryGirl.create(:player_camp_registration, 
                                                              player_id: player.id,
                                                              camp_id: camp3.id) } 

      before { click_link "My Home" }

      before { click_link "Un-Register"}
      
      it { should have_selector('div.alert.alert-success') }
      it { should have_title "Home of #{user.first_name}" }

      it { should have_link "Register" }
      it { should have_content "Camp Invitation" }
      it { should_not have_content "Camp Registration" }

    end
  end
end  