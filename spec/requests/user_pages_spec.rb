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

  let(:submit_code) { "Submit Code" }
  let(:submit) { "Submit" }

	subject { page }

	describe "Sign Up" do

    describe "by going straight to Sign Up page" do

      before { visit signup_path }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-notice', text: 'A valid Invitation Code must be submitted before Signing Up.') }

    end

    describe "without Invitation Code" do

      before { visit signin_path }

      it { should have_title('Sign In') }

      before { click_button submit_code }

      it { should have_selector('div.alert.alert-error', text: 'The Invitation Code submitted did not match our records. Try again.') }

    end

    before { visit signin_path }

    it { should have_title('Sign In') }

    describe "with expired Invitation Code" do

      before do
        fill_in 'Invitation Code',    with: expired_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'This Invitation Code has expired. Contact support@number9hockey.com if you believe there has been an error.') }    

    end

    describe "with used Invitation Code" do

      before do
        fill_in 'Invitation Code',    with: used_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error', text: 'This Invitation Code has already been used. Only one Invitation Code per person.') }  

    end

    describe "with valid Invitation Code" do
      
      before do
        fill_in 'Invitation Code',    with: valid_invitation.invitation_code
        click_button submit_code
      end

      it { should have_title('Sign Up') }

      describe 'Sign Up' do

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
            fill_in "First Name",    with: "Example"
            fill_in "Last Name",     with: "User"
            fill_in "Email",         with: "user@example.com"
            fill_in "Password",      with: "foobar"
            fill_in "Confirmation",  with: "foobar"
          end

          it "should create a user" do
            expect { click_button submit }.to change(User, :count).by(1)
          end

          describe "after saving the user" do
            before { click_button submit }
            
            let(:user) { User.find_by(email: "user@example.com") }

            it { should have_link('Sign Out') }
            it { should have_title(user.first_name) }
            it { should have_selector('div.alert.alert-success', text: "Welcome") }
          end

# => need to check that Player is correctly linked to User
# => need to check that Coach is correctly linked to User
        end
      end
    end
  end

  describe "Sign In user" do
    
    let!(:user_signin) { FactoryGirl.create(:user) }

    before { visit signin_path }

    before do
      fill_in "Email",    with: user_signin.email.upcase
      fill_in "Password", with: user_signin.password
      click_button "Sign In"
    end

    it { should have_link('Sign Out') }
    
    describe "Home page" do

      it { should have_title(user_signin.first_name) }

    end

    describe "Profile page" do

      before { click_link "My Profile" }

      it { should have_title("Profile for #{user_signin.first_name}") }

      describe "without linked Player" do
        it { should_not have_content('My Player') }
        it { should_not have_content("My Coach's Profile") }
      end

      describe "with one linked Player" do
        
        let!(:user_to_player1) { FactoryGirl.create(:user_to_player, 
                                                    user_id: :user_signin.id, 
                                                    player_id: :player1.id) }
        
        before { click_link "My Profile" }

        it { should have_content('My Player') }
        it { should have_content(player1.last_name) }
        it { should_not have_content(player2.last_name) }

      end

      describe "with two linked Players" do
        
        let!(:user_to_player2) { FactoryGirl.create(:user_to_player, 
                                                    user_id: :user_signin.id, 
                                                    player_id: :player2.id) }

        before { click_link "My Profile" }

        it { should have_content('My Players') }
        it { should have_content(player2.last_name) }

      end

      describe "with linked Coach" do

        #create the link to the coach's record
        #let!(:coach1) { FactoryGirl.create(:coach, last_name: 'Player3') }
        #let!(:user_to_coach) { FactoryGirl.create(:user_to_coach, user_id: user, coach_id: coach) }

        #before { visit user_path(user) } 

        #it { should have_content("My Coach's Profile") }
        #it { should have_content(coach1.last_name) }

      end

      describe "edit User information" do
        
        before { click_link "My Profile" }
        before { click_link "Edit My Info" }

        describe "edit page" do
          it { should have_content("Update your profile") }
          it { should have_title("Edit My Info") }
        end

        describe "with invalid information" do

          before do
            fill_in "Email",    with: ''
            click_button "Save Changes"
          end
          
          it { should have_selector('div.alert.alert-error') }
          
        end

        describe "with valid information" do
          before do
            fill_in "Email",    with: 'newemail@example.com'
            fill_in "Password", with: 'foobar'
            fill_in "Confirm Password", with: 'foobar'
          end

          it "should not create a user" do
            expect { click_button "Save Changes" }.not_to change(User, :count)
          end

          before { click_button "Save Changes" }

          it { should have_selector('div.alert.alert-success', text: "User information updated.") }

        end
      end
    end
  end
end

#   describe "profile page" do
#     let(:user) { FactoryGirl.create(:user) }
#     before { visit user_path(user) }

#      it { should have_content(user.first_name) }
#       it { should have_title(user.first_name) }
#   end
