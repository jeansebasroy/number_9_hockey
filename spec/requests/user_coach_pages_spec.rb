require 'rails_helper'

describe "User Coach pages" do

  let!(:user) { FactoryGirl.create(:user) }
  #let!(:coach) { FactoryGirl.create(:coach) }
  #let!(:user_to_coach) { FactoryGirl.create(:user_to_coach) }

	subject { page }

  describe "Sign In user" do

    before { visit signin_path }

    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    it { should have_link('Sign Out') }
    
    describe "Home page" do

      it { should have_title(user.first_name) }

    end

    describe "Profile page" do

      before { click_link "My Profile" }

      it { should have_title("Profile for #{user.first_name}") }

      describe "without linked Coach" do
        it { should_not have_content("My Coach's Profile") }
      end

      describe "with linked Coach" do

        #create the link to the coach's record
        #let!(:coach1) { FactoryGirl.create(:coach, last_name: 'Player3') }
        #let!(:user_to_coach) { FactoryGirl.create(:user_to_coach, user_id: user, coach_id: coach) }

        #before { visit user_path(user) } 

        #it { should have_content("My Coach's Profile") }
        #it { should have_content(coach1.last_name) }

        describe "edit Coach information" do

        end
      end
    end
  end
end
