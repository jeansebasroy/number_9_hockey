require 'rails_helper'

describe "Admin sign in" do
	
  let(:admin_user) { FactoryGirl.create(:admin) }
  let(:base_title) { "#9 Hockey" }
  # need to create a 'helper' file to define this for both "Static pages" & "User pages"

	subject { page }

  before { visit signin_path }

  before do
   	fill_in "Email",    with: admin_user.email.upcase
    fill_in "Password", with: admin_user.password
    click_button "Sign In"
  end

  describe "has Admin navigation" do
  
    it { should have_content("My Home") }
   	it { should have_content("Camps") }
   	it { should have_content("Players") }
   	it { should have_content("Coaches") }
    it { should have_content("Profile") }

   		
  	it { should have_link('Sign Out',	   href: signout_path) }
    it { should_not have_link('Sign In', href: signin_path) }

  end

  describe "on My Home page" do
   		
    it { should have_title("#{base_title}") }

  end

  describe "create new Camp" do

    let!(:age_group) { FactoryGirl.create(:age_group) }

    before { click_link "New Camp" }

    it { should have_title('Create Camp') }
    it { should have_content('Create Camp') }

    describe "Save" do

      let(:save) { "Save" }

      describe "with invalid information" do
          
        it "should not create a new camp" do
          expect { click_button save }.not_to change(Camp, :count)
        end

        before { click_button save }

        it { should have_selector('div.alert.alert-error') }

      end

      describe "with valid information" do
        
        before do
          fill_in "Name",               with: "Test Camp"
          fill_in "Description",        with: "This camp is for testing."
          select 'Mite', from: "camp[age_group]"
          #fill_in "Select Age Group:",  with: age_group.name
        end

        it "should create a new camp" do
          expect { click_button save }.to change(Camp, :count).by(1)
        end
      
        describe "show Camp page" do
          before { click_button save }

          it { should have_content("Test Camp") }
          it { should have_selector('div.alert.alert-success') }

          describe "edit Camp" do

            before { click_link "Edit" }

            it { should have_content("Update") }

            before do
              fill_in "Name",         with: "2 for Camp Test"
              fill_in "Description",  with: "This camp is for testing edits."
            end

            it "should not create a new camp" do
              expect { click_button "Update" }.not_to change(Camp, :count)
            end
            
            describe "Update" do
              
              before { click_button "Update" }
          
              it { should have_content("2 for Camp Test") }
              it { should_not have_content("Test Camp") }  

            end

          end

          describe "Publish Camp" do
            
            before { click_link "Publish" }

            it { should have_selector('div.alert.alert-success') }

            it { should have_content(Date.today)}

# => check that the database attribute is not nil
            describe "then Un-Publish Camp" do

              before { click_link "Un-Publish" }

              it { should have_selector('div.alert.alert-success') }

              it { should_not have_content(Date.today)}              
# => check that the database attribute is nil

            end
          end
        end
      end
    end
  end

  describe "view All Camps" do
    before { click_link "All Camps" }

    it { should have_link('View') }
    it { should have_link('Edit') }

  end


  describe "create new Player" do
    before { click_link "New Player" }

    it { should have_title('New Player') }
    it { should have_content('New Player') }

    describe "Save" do

      let(:save) { "Save" }

      describe "with invalid information" do
                
        it "should not create a new Player" do
          expect { click_button save }.not_to change(Player, :count)
        end

        before { click_button save }

        it { should have_selector('div.alert.alert-error') }

      end

      describe "with valid information" do
        before do
          fill_in "First Name:",          with: "First"
          fill_in "Last Name:",           with: "Last"
          select '1979', from: 'date_of_birth_1i'
          select 'April', from: 'date_of_birth_2i'
          select '12', from: 'date_of_birth_3i'
          #fill_in "Date of Birth:",       with: "1979-04-12"
          select 'Right', from: 'shoots'
          #fill_in "Shoots:",              with: "Right"
          select 'Practice', from: 'type_of_evaluation'
          #fill_in "Type of Evaluation:",  with: "Practice"
          fill_in "League:",              with: "NHL"
          fill_in "Team:",                with: "Blackhawks"
          select '2014', from: 'date_of_evaluation_1i'
          select 'August', from: 'date_of_evaluation_2i'
          select '8', from: 'date_of_evaluation_3i'
          #fill_in "Date of Evaluation:",  with: "2014-08-08"
        end

        it "should create a new camp" do
          expect { click_button save }.to change(Player, :count).by(1)
        end
      
        describe "show Player page" do
          before { click_button save }

          it { should have_selector('div.alert.alert-success') }

        end
      end
    end
  end

  describe "view All Players" do
    before { click_link "All Players" }

    it { should have_link('Evaluate') }
    it { should have_link('View') }
    it { should have_link('Edit') }
    
  end

  describe "create new Coach" do

    	
  end

  describe "view All Coaches" do
      
# =>     before { click_link "All Players" }

# =>     it { should have_link('Evaluate') }
# =>     it { should have_link('View') }
# =>     it { should have_link('Edit') }      

  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end

# => For Saving tests
#        gives ability to save
# => creates new camp
# => takes user to "show" page

#        describe "after Saving" do

#          describe "Edit" do
# =>         before { click_button 'Edit' }


# => allows admin to edit the camp's details

# =>         before { click_button 'Save' }

#          end

#          describe "Publish" do
# =>         before { click_button 'Publish' }

# => allows admin to "Pulish" camp details so users can see

#          end


# => For Reference
#       it { should have_link('All Camps',    href: user_path(user)) }
#       it { should have_link('Search Camps', href: user_path(user)) }
#       it { should have_link('New Camp',   href: user_path(user)) }

#   it { should have_link('All Players',  href: user_path(user)) }
#       it { should have_link('Search Players', href: user_path(user)) }
#       it { should have_link('New Player',   href: signout_path) }
      
#       it { should have_link('All Coaches',  href: user_path(user)) }
#       it { should have_link('Search Coaches', href: user_path(user)) }
#       it { should have_link('New Coach',    href: signout_path) }