require 'rails_helper'

describe "Player Camp Registration pages" do

  let!(:rink) { FactoryGirl.create(:rink) }
  let!(:age_group) { FactoryGirl.create(:age_group) }
  let!(:camp) { FactoryGirl.create(:camp, age_group: age_group.id) }    
  let!(:date_time_location) { FactoryGirl.create(:date_time_location,
                                  camp_id: camp.id, 
                                  rink_id: rink.id) }

  subject { page }
  
  describe "Register for Camp" do

    let!(:user_register) { FactoryGirl.create(:user) }
    let!(:player_register) { FactoryGirl.create(:player) }
    let!(:user_to_player_register) { FactoryGirl.create(:user_to_player, 
                                              user_id: user_register.id,
                                              player_id: player_register.id) }

    let!(:camp_register_invitation) { FactoryGirl.create(:player_camp_invitations, 
                                                        player_id: player_register.id,
                                                        camp_id: camp.id) }  
  
    before { visit signin_path }

    before do
      fill_in "Email",    with: user_register.email.upcase
      fill_in "Password", with: user_register.password
      click_button "Sign In"
    end

    before { click_link 'Register' }

    it { should have_title "Register" }
    it { should have_button 'Register' }

    describe "with invalid information" do

# => fix this
#        it "should not create a Registration" do
#          expect { click_button "Submit Registration" }.not_to change(Camp Registration, :count)
#        end

      before { click_button 'Register' }

      it { should have_selector('div#error_explanation') }
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
      it { should have_title "Home of #{user_register.first_name}" }
      it { should_not have_title 'Register' }

# => is 'true because 'Un-Register' contains 'Register'
      #it { should_not have_link 'Register' }
      it { should have_link 'Update' }
      it { should have_link 'Un-Register' }

      it { should_not have_content 'Camp Invitation:' }
      it { should have_content 'Camp Registration:' }

    end
  end


  describe "Update Camp Registration" do

    let!(:user_update) { FactoryGirl.create(:user) }
    let!(:player_update) { FactoryGirl.create(:player) }
    let!(:user_to_player_update) { FactoryGirl.create(:user_to_player, 
                                              user_id: user_update.id,
                                              player_id: player_update.id) }
  
    let!(:camp_update_registration) { FactoryGirl.create(:player_camp_registration,
                                                        player_id: player_update.id,
                                                        camp_id: camp.id) }
    
    before { visit signin_path }

    before do
      fill_in "Email",    with: user_update.email.upcase
      fill_in "Password", with: user_update.password
      click_button "Sign In"
    end

    before { click_link 'Update Registration' }

    it { should have_title "Update Registration" }

    describe "with invalid information" do

      before { click_button "Update" }

      it { should have_selector('div#error_explanation') }
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
      it { should have_title "Home of #{user_update.first_name}" }
      it { should_not have_title 'Register' }

    end
  end

  describe "Un-Register from Camp" do

    let!(:user_unregister) { FactoryGirl.create(:user) }
    let!(:player_unregister) { FactoryGirl.create(:player) }
    let!(:user_to_player_unregister) { FactoryGirl.create(:user_to_player, 
                                              user_id: user_unregister.id,
                                              player_id: player_unregister.id) }
  
    let!(:camp_unregister) { FactoryGirl.create(:player_camp_registration,
                                                        player_id: player_unregister.id,
                                                        camp_id: camp.id) }

    let!(:camp_unregister_invitation) { FactoryGirl.create(:player_camp_invitations, 
                                                        player_id: player_unregister.id,
                                                        camp_id: camp.id) }  
  
    before { visit signin_path }

    before do
      fill_in "Email",    with: user_unregister.email.upcase
      fill_in "Password", with: user_unregister.password
      click_button "Sign In"
    end

    before { click_link "Un-Register"}
      
    it { should have_selector('div.alert.alert-success') }
    it { should have_title "Home of #{user_unregister.first_name}" }

    it { should have_link "Register" }
    it { should have_content "Camp Invitation" }
    it { should_not have_content "Camp Registration" }

  end

  describe "Un-Published Camp" do

    let!(:user_un_published) { FactoryGirl.create(:user) }
    let!(:player_un_published) { FactoryGirl.create(:player) }
    let!(:user_to_player_un_published) { FactoryGirl.create(:user_to_player, 
                                              user_id: user_un_published.id,
                                              player_id: player_un_published.id) }
  
    let!(:camp_un_published) { FactoryGirl.create(:camp, age_group: age_group.id, publish_date: '') }    

    let!(:camp_registration_un_published) { FactoryGirl.create(:player_camp_registration,
                                                        player_id: player_un_published.id,
                                                        camp_id: camp_un_published.id) }
    
    before { visit signin_path }

    before do
      fill_in "Email",    with: user_un_published.email.upcase
      fill_in "Password", with: user_un_published.password
      click_button "Sign In"
    end

    it { should_not have_content camp_un_published.name }

  end
end  