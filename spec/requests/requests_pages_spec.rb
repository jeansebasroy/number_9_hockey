require 'rails_helper'

describe "Requests pages" do
	
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  describe "submit Contact Us request from Home page" do

    before { visit root_path }

    before { click_link "Contact Us" }

    it { should have_title("Contact Us") }
    
    describe "with invalid information" do

      before { click_button "Submit" }

      it { should have_selector('div.alert.alert-error') }

    end

    describe "with valid information" do
      before do
        fill_in "First Name", with: user.first_name
        fill_in "Last Name",  with: user.last_name
        fill_in "Email",      with: user.email
        fill_in "Message",    with: "Info"
        click_button "Submit"
      end
    
      it { should have_selector('div.alert.alert-success') }
      it { should have_title("#9 Hockey") }

    end
    
  end

  describe "submit Scouting request from Why #9?" do

    before { visit root_path }

    before { click_link "Why #9?" }

    before { click_link "Scouting" }

    it { should have_title("Scouting Request") }
    
    describe "with invalid information" do
      
      before { click_button "Submit" }

      it { should have_selector('div.alert.alert-error') }

    end

    describe "with valid information" do
      before do
        fill_in "First Name", with: user.first_name
        fill_in "Last Name",  with: user.last_name
        fill_in "Email",      with: user.email
        fill_in "Message",    with: "Scouting"
        click_button "Submit"
      end
    
      it { should have_selector('div.alert.alert-success') }
      it { should have_title("Why #9?") }

    end
    
  end

  describe "submit Support request from Sign In path" do

    before { visit signin_path }

    before { click_link "Support" }

    it { should have_title("Support Request") }
    
    describe "with invalid information" do
      
      before { click_button "Submit" }

      it { should have_selector('div.alert.alert-error') }

    end

    describe "with valid information" do
      before do
        fill_in "First Name", with: user.first_name
        fill_in "Last Name",  with: user.last_name
        fill_in "Email",      with: user.email
        fill_in "Message",    with: "Support"
        click_button "Submit"
      end
    
      it { should have_selector('div.alert.alert-success') }
      it { should have_title("Sign In") }

    end
    
  end

end