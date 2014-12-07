require 'rails_helper'

describe "User Player pages" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:player1) { FactoryGirl.create(:player, last_name: 'Player1') }
  let!(:player2) { FactoryGirl.create(:player, last_name: 'Player2') }

	subject { page }

  describe "Sign In user" do

    before { visit signin_path }

    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    it { should have_link('Sign Out') }
    
    describe "Profile page" do

      before { click_link "My Profile" }

      it { should have_title("Profile for #{user.first_name}") }

      describe "without linked Player" do
        it { should_not have_content('My Player') }
        it { should_not have_content("My Coach's Profile") }
      end

      describe "with one linked Player" do
        
        let!(:user_to_player1) { FactoryGirl.create(:user_to_player, 
                                                    user_id: user.id, 
                                                    player_id: player1.id) }
        
        before { click_link "My Profile" }

        it { should have_content('My Player') }
        it { should have_content(player1.last_name) }
        it { should_not have_content(player2.last_name) }

        describe "edit Player information" do
        
          before { click_link "Edit Player Info" }

          describe "edit Player page" do
            it { should have_content("Update Player") }
            it { should have_title("Edit Player") }
          end

          describe "with invalid information" do

            before do
              fill_in "Last Name",    with: ''
              click_button "Update"
            end
            
            it { should have_selector('div#error_explanation') }
            
          end

          describe "with valid information" do
            before do
              fill_in "Last Name",    with: 'Gretzky'
              select 'Right',         from: 'player[shoots]'
            end

# => need to fix
#            it "should not create a Player" do
#              expect { click_button "Update" }.not_to change(Player, :count)
#            end

            before { click_button "Update" }

            it { should have_selector('div.alert.alert-success', text: "Player information updated.") }

            it { should have_title("Profile for #{user.first_name}") }  

          end
        end

        describe "with two linked Players" do
        
          let!(:user_to_player2) { FactoryGirl.create(:user_to_player, 
                                                      user_id: user.id, 
                                                      player_id: player2.id) }

          before { click_link "My Profile" }

          it { should have_content('My Players') }
          it { should have_content(player2.last_name) }

        end
      end
    end

    describe "Home page" do

      let!(:user_to_player1) { FactoryGirl.create(:user_to_player, 
                                                        user_id: user.id, 
                                                        player_id: player1.id) }
      let!(:user_to_player2) { FactoryGirl.create(:user_to_player, 
                                                        user_id: user.id, 
                                                        player_id: player2.id) }
      before { click_link "My Home" }      

      it { should have_title(user.first_name) }

      it { should have_content("#{player1.last_name}") }
      it { should have_content("#{player2.last_name}") }
      it { should have_content("Date of Birth") }
      it { should have_content("Shoots")}
    end
  end
end
