require 'rails_helper'

describe "Admin sign in" do
	
  let(:base_title) { "#9 Hockey" }
  let(:admin_user) { FactoryGirl.create(:admin) }
  # need to create a 'helper' file to define this for both "Static pages" & "User pages"

	subject { page }

  before { visit signin_path }

  before do
   	fill_in "Email",    with: admin_user.email.upcase
    fill_in "Password", with: admin_user.password
    click_button "Sign In"
  end

  describe "has Admin navigation" do
  
    it { should have_link("My Home") }
   	it { should have_link("Camps") }
   	it { should have_link("Players") }
   	it { should have_link("Coaches") }
    it { should have_link("Profile") }
   		
  	it { should have_link('Sign Out',	   href: signout_path) }
    it { should_not have_link('Sign In', href: signin_path) }

  end

  describe "on My Home page" do
   		
    it { should have_title("#{base_title}") }

  end

  describe "create new Coach" do

    	
  end

  describe "view All Coaches" do

# =>     let!(:coach) { FactoryGirl.create(:coach) }  
      
# =>     before { click_link "All Coaches" }

# =>     it { should have_link('Evaluate') }
# =>     it { should have_link('View') }
# =>     it { should have_link('Edit') }      

  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end