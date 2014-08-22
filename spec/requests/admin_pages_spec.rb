require 'rails_helper'

describe "Admin sign in" do
	
	subject { page }

   	let(:admin_user) { FactoryGirl.create(:admin) }
    before { visit signin_path }

    before do
    	fill_in "Email",    with: admin_user.email.upcase
        fill_in "Password", with: admin_user.password
        click_button "Sign In"
    end

    describe "with Admin navigation" do

    	it { should have_content("My Home") }
    	it { should have_content("Camps") }
    	it { should have_content("Players") }
    	it { should have_content("Coaches") }
      it { should have_content("Profile") }
   		
#   		it { should have_link('All Camps',		href: user_path(user)) }
#   		it { should have_link('Search Camps',	href: user_path(user)) }
#   		it { should have_link('New Camp',		href: user_path(user)) }

#		it { should have_link('All Players',	href: user_path(user)) }
#   		it { should have_link('Search Players',	href: user_path(user)) }
#   		it { should have_link('New Player', 	href: signout_path) }
   		
#   		it { should have_link('All Coaches',	href: user_path(user)) }
#   		it { should have_link('Search Coaches',	href: user_path(user)) }
#   		it { should have_link('New Coach',  	href: signout_path) }
   		
   		it { should have_link('Sign Out',	href: signout_path) }
   		it { should_not have_link('Sign In', href: signin_path) }
    end

    describe "with My Home page" do
   		
   		it { should have_content("Admin") }

    end

    describe "with New Camps page" do
    	before { click_link "Sign Out" }

      it { should have_title('Create Camp') }
      it { should have_content('Create Camp') }

      describe "Saving" do
        before { click_button 'Save' }

#        gives ability to save without publishing

      end

      describe "Publish" do
#        before { click_button 'Publish' }

#      check that published camp shows up under "All"

      end

    end


    describe "with Players page" do
    	
    end

    describe "with Coaches page" do
    	
    end

    describe "admin sign out" do
    	before { click_link "Sign Out" }
    	it { should have_link('Sign In') }
    end

	
#      		it { should have_title(user.first_name) }
#      		it { should_not have_link('Sign In', href: signin_path) }
    	
#   	it { should have_content(user.first_name) }
#   	before { visit signup_path }

#      	it "should create a user" do
#         	expect { click_button submit }.to change(User, :count).by(1)
#      	end

#          it { should have_link('Sign Out') }
#          it { should have_title(user.first_name) }
#          it { should have_selector('div.alert.alert-success', text: "Welcome") }

end
