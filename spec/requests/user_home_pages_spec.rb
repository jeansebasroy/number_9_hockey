require 'rails_helper'

describe "User pages" do

  let!(:player1) { FactoryGirl.create(:player, last_name: 'Player1') }
  let!(:player2) { FactoryGirl.create(:player, last_name: 'Player2') }
  let!(:player3) { FactoryGirl.create(:player, last_name: 'Player3') }

  let!(:expired_invitation) { FactoryGirl.create(:user_invitation, 
                                                  invitation_code: 'A1234567',
                                                  expiration_date: (Date.today - 1.day),
                                                  player_id: player1.id) }
  let!(:used_invitation) { FactoryGirl.create(:user_invitation, 
                                                  invitation_code: 'B1234567', 
                                                  use_date: (Date.today),
                                                  player_id: player2.id) }
  let!(:valid_invitation) { FactoryGirl.create(:user_invitation, 
                                                  invitation_code: 'C1234567', 
                                                  player_id: player3.id) }

  let(:submit_code) { "Submit to Forge Greatness" }
  let(:submit) { "Submit" }

	subject { page }

	describe "Sign Up" do

    describe "by going straight to Sign Up page" do

      before { visit signup_path }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-notice', text: 'A valid Invitation Code must be submitted before Signing Up.') }

    end

    describe "without Invitation Code" do

      before { visit root_url }

      it { should have_title('#9 Hockey') }

      before { click_button submit_code }

      it { should have_selector('div.alert.alert-error', text: 'The Invitation Code submitted did not match our records. Try again.') }

    end

    before { visit root_url }

    it { should have_title('#9 Hockey') }

    describe "with expired Invitation Code" do

      before do
        fill_in 'Invitation Code',    with: expired_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('#9 Hockey') }
      it { should have_selector('div.alert.alert-error', text: 'This Invitation Code has expired. Contact support@number9hockey.com if you believe there has been an error.') }    

    end

    describe "with used Invitation Code" do

      before do
        fill_in 'Invitation Code',    with: used_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('#9 Hockey') }
      it { should have_selector('div.alert.alert-error', text: 'This Invitation Code has already been used. Only one Invitation Code per person.') }  

    end

    describe "with valid Invitation Code" do
      
      before do
        fill_in 'Invitation Code',    with: valid_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('Sign Up') }

      describe 'Sign Up' do

        let!(:rink) { FactoryGirl.create(:rink) }
        let!(:age_group) { FactoryGirl.create(:age_group) }

        let!(:camp1) { FactoryGirl.create(:camp, name: 'Camp1', age_group: age_group) }

        let!(:player_camp_invitations1) { FactoryGirl.create(:player_camp_invitations, player_id: player3.id,
                                                              camp_id: camp1.id) }

        describe 'with invalid information' do

          it "should not create a user" do
            expect { click_button submit }.not_to change(User, :count)
          end

          describe "after submission" do
            before { click_button submit }

            it { should have_title("Sign Up") }
            it { should have_selector('div.alert.alert-error') }

          end
        end

        describe 'with valid information' do
          before do
            fill_in "First Name",       with: "Example"
            fill_in "Last Name",        with: "User"
            fill_in "Email",            with: "user@example.com"
            fill_in "Password",         with: "foobar"
            fill_in "Confirm Password", with: "foobar"
          end

          it "should create a user" do
            expect { click_button submit }.to change(User, :count).by(1)
          end

          describe "after saving the user" do
            before { click_button submit }
            
            let(:user) { User.find_by(email: "user@example.com") }

            it { should have_link('Sign Out') }
            it { should have_selector('div.alert.alert-success', text: "Welcome") }

            # => checks that user is sent to Registration page on on first sign-up
            it { should have_title('Register') }

          end

# => need to check that Player is correctly linked to User
# => need to check that Coach is correctly linked to User
        end
      end
    end
  end

  describe "Sign In user" do
    
    let!(:user_signin) { FactoryGirl.create(:user) }
    let!(:player5) { FactoryGirl.create(:player, last_name: 'Player5') }
    let!(:player6) { FactoryGirl.create(:player, last_name: 'Player6') }

    let!(:rink) { FactoryGirl.create(:rink) }
    let!(:age_group) { FactoryGirl.create(:age_group) }

    let!(:camp2) { FactoryGirl.create(:camp, name: 'Camp2', age_group: age_group) }
    let!(:camp3) { FactoryGirl.create(:camp, name: 'Camp3', age_group: age_group) }

    before { visit signin_path }

    before do
      fill_in "Email",    with: user_signin.email.upcase
      fill_in "Password", with: user_signin.password
      click_button "Sign In"
    end

    it { should have_link('Sign Out') }
    
    describe "Home page" do

      it { should have_title(user_signin.first_name) }

      describe "without a linked Player" do

        it { should_not have_content "My Player" }

      end

      describe "with one linked Player" do
        let!(:user_to_player1) { FactoryGirl.create(:user_to_player, user_id: user_signin.id, 
                                                player_id: player5.id) }

        before { click_link 'My Home' }

        it { should have_content "My Player:" }
        it { should have_content player5.last_name }

        describe "without a camp invitation" do

          it { should_not have_content "Camp Invitations:" }

        end

        describe "with a Camp invitation" do
          let!(:player_camp_invitations2) { FactoryGirl.create(:player_camp_invitations, player_id: player5.id,
                                                              camp_id: camp2.id) }

          before { click_link 'My Home' }

          it { should have_content player5.last_name }
          it { should have_content camp2.name }
          it { should_not have_content camp3.name }

        end
      end

      describe "with two linked Players" do
        let!(:user_to_player2) { FactoryGirl.create(:user_to_player, user_id: user_signin.id, 
                                                player_id: player5.id) }
        
        let!(:user_to_player3) { FactoryGirl.create(:user_to_player, user_id: user_signin.id, 
                                                player_id: player6.id) }
        
        before { click_link 'My Home' }

        it { should have_content "My Players:" }
        it { should have_content player5.last_name }
        it { should have_content player6.last_name }    

      end
    end

    describe "Profile page" do

      before { click_link "My Profile" }

      it { should have_title("Profile for #{user_signin.first_name}") }

      describe "edit User information" do
        
        before { click_link "My Profile" }
        before { click_link "Edit My Info" }

        describe "edit page" do
          it { should have_content("Update your profile") }
          it { should have_title("Edit My Info") }


          describe "with invalid information" do

            before do
              fill_in "Email",    with: ''
              click_button "Save Changes"
            end
            
            it { should have_selector('div.alert.alert-error') }
            it { should have_title("Edit My Info") }
            
          end

          describe "with valid information" do
            before do
              fill_in "Email",    with: 'newemail@example.com'
              fill_in "Password", with: 'foobar'
              fill_in "Confirm Password", with: 'foobar'
            end

# => fix this
#          it "should not create a user" do
#            expect { click_button "Save Changes" }.not_to change(User, :count)
#          end

            before { click_button "Save Changes" }

            it { should have_selector('div.alert.alert-success', text: "User information updated.") }

          end
        end
      end
      
      describe "with linked Player" do
        let!(:player7) { FactoryGirl.create(:player, last_name: 'Player6') }
        let!(:user_to_player4) { FactoryGirl.create(:user_to_player, user_id: user_signin.id, 
                                                      player_id: player7.id) }
      
        before { click_link "My Profile" }

        it { should have_content "My Player:" }
        it { should have_content player7.last_name }

        describe "edit Player information" do

          before { click_link "Edit Player Info" }

          it { should have_title "Edit Player" }

          describe "with invalid information" do

            before do
              fill_in "First Name",  with: ""
            end

# => fix this
#            it "should not create a Player" do
#              expect { click_button "Save Changes" }.not_to change(Player, :count)
#            end

            before { click_button "Update" }

            it { should have_selector('div.alert.alert-error') }
            it { should have_title('Edit Player') }

          end

          describe "with valid information" do
            before do
              fill_in "First Name",  with: "Maurice"
              fill_in "Last Name",   with: "Richard"

              select '2009',          from: 'player[date_of_birth(1i)]'
              select 'April',         from: 'player[date_of_birth(2i)]'
              select '12',            from: 'player[date_of_birth(3i)]'
              select 'Right',         from: 'player[shoots]'
            end

# => fix this
#            it "should not create a Player" do
#              expect { click_button "Save Changes" }.not_to change(Player, :count)
#            end

            before { click_button "Update" }

            it { should have_selector('div.alert.alert-success') }
            it { should have_title("Profile for #{user_signin.first_name}") }

          end
        end
      end
    end
  end
end

# => describe "reset user password" do

#   describe "profile page" do
#     let(:user) { FactoryGirl.create(:user) }
#     before { visit user_path(user) }

#      it { should have_content(user.first_name) }
#       it { should have_title(user.first_name) }
#   end
