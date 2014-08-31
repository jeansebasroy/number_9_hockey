require 'rails_helper'

describe "Admin Player pages" do
	
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

# => test for edge case where player information is valid, but player_evaluation information is not

      describe "with valid information" do
        before do
          fill_in "First Name:",  with: "Maurice"
          fill_in "Last Name:",   with: "Richard"

          select '2009',          from: 'player[date_of_birth(1i)]'
          select 'April',         from: 'player[date_of_birth(2i)]'
          select '12',            from: 'player[date_of_birth(3i)]'
          select 'Right',         from: 'player[shoots]'
          
          select 'Practice',      from: 'player_evaluation[evaluation_type]'
          
          fill_in "League:",      with: "NHL"
          fill_in "Team:",        with: "Canadiens"
          
          select '2014',          from: 'player_evaluation[date(1i)]'
          select 'August',        from: 'player_evaluation[date(2i)]'
          select '8',             from: 'player_evaluation[date(3i)]'
          
        end

        it "should create a new Player" do
          expect { click_button save }.to change(Player, :count).by(1)
        end
      
        it "should create a new Player Evaluation" do
          expect { click_button save }.to change(PlayerEvaluation, :count).by(1)
        end

        describe "show Player page" do
          before { click_button save }

          it { should have_content("Maurice Richard") }
          it { should have_selector('div.alert.alert-success') }

          describe "edit Player" do

            before { click_link "Edit Player" }

            it { should have_content("Update") }

            before do
              fill_in "First Name:", with: "Henri"
              select 'Left',         from: 'player[shoots]'
            end

            it "should not create a new Player" do
              expect { click_button "Update" }.not_to change(Player, :count)
            end
            
            describe "Update" do
              
              before { click_button "Update" }
          
              it { should have_content("Henri Richard") }
              it { should_not have_content("Maurice Richard") }  

            end
          end
        end
      end
    end
  end

  describe "view All Players" do

    let!(:player) { FactoryGirl.create(:player) }  

    before { click_link "All Players" }
 
    it { should have_title("#{base_title} | All Players") }
    it { should have_link('Evaluate') }
    it { should have_link('View') }
    it { should have_link('Edit') }
    
  end

  describe "evaluate existing Player" do
    
    let!(:player) { FactoryGirl.create(:player) }  
    #let!(:eval1) { FactoryGirl.create(:player_evaluation, player: player) }

    it { should have_link("All Players") }
    before { click_link "All Players" }

    it { should have_link("All Players") }
    #it { should have_title("#{base_title} | All Camps") }
    it { should have_title("All Players") }
    
    it { should have_link("Add Player")}

    it { should have_link("Evaluate") }
    before { click_link "Evaluate" }
    
    it { should have_title("#{base_title} | Evaluate Player") }
    it { should have_content('Create an Evaluation for Richard, Maurice')}

    describe "Save Evaluation" do

      let(:save_evaluation) { "Save Evaluation" }

#      describe "with invalid information" do
                
#        it "should not create a new Player Evaluation" do
#          expect { click_button save_evaluation }.not_to change(PlayerEvaluation, :count)
#        end

#        before { click_button save_evaluation }

#        it { should have_selector('div.alert.alert-error') }
#        it { should have_title("#{base_title} | Evaluate Player") }

#      end

      describe "with valid information" do

        it { should have_title("#{base_title} | Evaluate Player") }

        before do   
          select 'Practice',      from: 'player_evaluation[evaluation_type]'
          
          fill_in "League:",      with: "NHL"
          fill_in "Team:",        with: "Canadiens"
          
          select '2014',          from: 'player_evaluation[date(1i)]'
          select 'August',        from: 'player_evaluation[date(2i)]'
          select '8',             from: 'player_evaluation[date(3i)]'
          
        end

# => I'm having issues with these
        it "should not create a new Player" do
          expect { click_button save_evaluation }.not_to change(Player, :count)
        end

        it "should create a new Player Evaluation" do
          expect { click_button save_evaluation }.to change(PlayerEvaluation, :count).by(1)
        end

        before { click_button save_evaluation }

        it { should have_content("Maurice Richard") }
        it { should have_title("#{base_title} | Richard") }
        it { should have_selector('div.alert.alert-success') }

      end
    end
  end

  describe "edit existing evaluation" do
    
    let!(:player) { FactoryGirl.create(:player) }  
    let!(:eval1) { FactoryGirl.create(:player_evaluation, player: player) }

    before { click_link "All Players" }

# =>     it { should have_title("#{base_title} | All Players") }

#    before { click_link("View", match: :second) }
    before { click_link "View" }

    #it { should have_content('Maurice Richard') }
    #it { should have_title('Richard') }
# =>     it { should have_title("#{base_title} | Richard") }
# =>     it { should have_title(player.last_name) }

    before { click_link "Edit" }
    #before { click_link("Edit", match: :first) }
    #before { first(:link, "Edit Player").click }

    it { should have_title('Evaluate Player') }
    it { should_not have_title('Richard') }

    describe "Update Evaluation" do

      let(:update_evaluation) { "Update Evaluation" }

      describe "with invalid information" do
                
        before { click_button update_evaluation }

        it { should have_selector('div.alert.alert-error') }

      end

      describe "with valid information" do
        before do   
          select 'Practice',      from: 'player_evaluation[evaluation_type]'
          
          fill_in "League:",      with: "NHL"
          fill_in "Team:",        with: "Blackhawks"
          
          select '2014',          from: 'player_evaluation[date(1i)]'
          select 'August',        from: 'player_evaluation[date(2i)]'
          select '8',             from: 'player_evaluation[date(3i)]'
          
        end    

#        it "should not create a new Player Evaluation" do
#          expect { click_button update_evaluation }.not_to change(Player, :count)
#        end

        before { click_button update_evaluation }

# =>         it { should have_content("Blackhawks") }
# =>         it { should have_selector('div.alert.alert-success') } 

      end
    end
  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end