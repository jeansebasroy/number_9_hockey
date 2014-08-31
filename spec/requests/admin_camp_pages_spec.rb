require 'rails_helper'

describe "Admin Camp pages" do
	
  let(:admin_user) { FactoryGirl.create(:admin) }
  let(:base_title) { "#9 Hockey" }
  # need to create a 'helper' file to define this for both "Static pages" & "User pages"
  let!(:rink) { FactoryGirl.create(:rink) }

	subject { page }

  before { visit signin_path }

  before do
   	fill_in "Email",    with: admin_user.email.upcase
    fill_in "Password", with: admin_user.password
    click_button "Sign In"
  end

  describe "create new Camp" do

    let!(:age_group) { FactoryGirl.create(:age_group) }
    let(:save) { "Save" }

    describe "from New Camp link" do

      before { click_link "New Camp" }

      it { should have_title("Create Camp") }

      describe "with invalid information" do
          
        it "should not create a new camp" do
          expect { click_button save }.not_to change(Camp, :count)
        end

        before { click_button save }

        it { should have_selector('div.alert.alert-error') }
        it { should have_title("")}

      end

      describe "with valid information" do
        
        before do
          fill_in "Name",         with: "Test Camp"
          fill_in "Description",  with: "This camp is for testing."
          select "Mite",          from: "camp[age_group]"
        end

        it "should create a new camp" do
          expect { click_button save }.to change(Camp, :count).by(1)
        end
      
        before { click_button save }

        it { should have_selector('div.alert.alert-success') }
        it { should have_title("Your Camp") }
        it { should have_content("Camp Name: Test Camp") }

        describe "Add Date" do
# => test adding date_time_locations to camp
          before { click_link "Add Date"}

          it { should have_title("Add Date") }

          describe "with invalid information" do
            
            it "should not create a Date Time Location" do
              expect { click_button save }.not_to change(DateTimeLocation, :count)
            end

          end

          describe "with valid information" do

            before do 
              select '2016',          from: 'date_time_location[date(1i)]'
              select 'August',        from: 'date_time_location[date(2i)]'
              select '8',             from: 'date_time_location[date(3i)]'

              select '18',            from: 'date_time_location[start_time(1i)]'
              select '00',            from: 'date_time_location[start_time(2i)]'

              select '19',            from: 'date_time_location[end_time(1i)]'
              select '30',            from: 'date_time_location[end_time(2i)]'

              select 'Skokie Skatium',from: 'date_time_location[rink]'

            end

            it "should create a new Date Time Location" do
              expect { click_button save }.to change(DateTimeLocation, :count).by(1)
            end

            before { click_button save}

            it { should have_selector('div.alert.alert-success') }
            it { should have_title("Your Camp") }
            it { should have_content("Camp Name: Test Camp") }

          end
        end
      end
    end
  end

  describe "view All Camps" do
    let!(:camp) { FactoryGirl.create(:camp) }  

    before { click_link "All Camps" }

    it { should have_title("#{base_title} | All Camps") }
    it { should have_link('View') }
    it { should have_link('Edit') }
    it { should have_link('Publish') }
    it { should have_link('Delete') }

  end

  describe "edit Camp" do
         
    before { click_link "Edit Camp" }

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

    describe "from Camp index" do
            
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

    describe "from Camp view" do

    end
  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end