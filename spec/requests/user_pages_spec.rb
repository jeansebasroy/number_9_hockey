require 'rails_helper'

describe "User pages" do

	subject { page }

  	describe "signup page" do
    	before { visit signup_path }

    	it { should have_content('Sign Up') }
    	it { should have_title(full_title('Sign Up')) }
  	end

	describe "sign up" do

    	before { visit signup_path }

    	let(:submit) { "Submit" }

    	describe "with invalid information" do
      		it "should not create a user" do
        		expect { click_button submit }.not_to change(User, :count)
      		end
    	end

    	describe "with valid information" do
      		before do
        		fill_in "First Name",   with: "Example"
        		fill_in "Last Name", 	with:  "User"
        		fill_in "Email",        with: "user@example.com"
        		fill_in "Password",     with: "foobar"
        		fill_in "Confirmation", with: "foobar"
      		end

      		it "should create a user" do
        	expect { click_button submit }.to change(User, :count).by(1)
      		end
    	end
  	end

  	describe "profile page" do
    	let(:user) { FactoryGirl.create(:user) }
    	before { visit user_path(user) }

    	it { should have_content(user.first_name) }
    	it { should have_title(user.first_name) }
  	end

end
