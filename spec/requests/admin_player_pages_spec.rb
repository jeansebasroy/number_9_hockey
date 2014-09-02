require 'rails_helper'

describe "Admin Player pages" do
	
  let(:admin_user) { FactoryGirl.create(:admin) }

  let!(:player) { FactoryGirl.create(:player) }
  let!(:player_evaluation) { FactoryGirl.create(:player_evaluation, player: player) }

  let(:save) { "Save" }

	subject { page }

  before { visit signin_path }

  before do
   	fill_in "Email",    with: admin_user.email.upcase
    fill_in "Password", with: admin_user.password
    click_button "Sign In"
  end

  describe "create new Player" do

    describe "from New Player link" do

      before { click_link "New Player" }

      it { should have_title('New Player') }
      
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
      end
    end
    
    describe "from Player index" do

      before { click_link "All Players" }

      it { should have_title('All Players') }

      before { click_link 'Add Player' }

      it { should have_title('New Player') }

      describe "with invalid information" do
                
        it "should not create a new Player" do
          expect { click_button save }.not_to change(Player, :count)
        end

        before { click_button save }

        it { should have_selector('div.alert.alert-error') }
        it { should have_title('New Player') }

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
      end    
    end
  end

  describe "edit existing Player" do
  
    describe "from Player view" do

      before { click_link "All Players" }

      before { click_link "View" }

      before { click_link "Edit Player" }
      
      it { should have_title('Edit Player') }

      describe "with invalid information" do
# => need to figure out how to test this
      end
      
      describe "with valid information" do

        before do
          fill_in "First Name:", with: "Henri"
          select 'Left',         from: 'player[shoots]'
        end

        it "should not create a new Player" do
          expect { click_button "Update" }.not_to change(Player, :count)
        end
                        
        before { click_button "Update" }
          
        it { should have_content("Henri Richard") }
        it { should_not have_content("Maurice Richard") }  
      end
    end

    describe "from Player index" do

      before { click_link "All Players" }

      before { click_link "Edit" }
      
      it { should have_title('Edit Player') }

      describe "with invalid information" do
# => need to figure out how to test this
      end
      
      describe "with valid information" do

        before do
          fill_in "First Name:", with: "Henri"
          select 'Left',         from: 'player[shoots]'
        end

        it "should not create a new Player" do
          expect { click_button "Update" }.not_to change(Player, :count)
        end
                        
        before { click_button "Update" }
          
        it { should have_content("Henri Richard") }
        it { should_not have_content("Maurice Richard") }  
      end

    end
  end

  describe "view All Players index" do

    before { click_link "All Players" }
 
    it { should have_title("All Players") }
    
  end

  describe "view Player details" do

    before { click_link "All Players" }
    before { click_link "View" }

    it { should have_title(player.last_name) }

  end

  describe "evaluate existing Player" do
    
    describe "from Player view" do
      before { click_link "All Players" }
      before { click_link "View" }
      before { click_link "Add Evaluation" }

      it { should have_title("Evaluate Player") }
      
      describe "with valid information" do
        before do
          select 'Game',      from: 'player_evaluation[evaluation_type]'
          
          fill_in "League:",      with: "NHL"
          fill_in "Team:",        with: "Canadiens"
          
          select '2014',          from: 'player_evaluation[date(1i)]'
          select 'August',        from: 'player_evaluation[date(2i)]'
          select '8',             from: 'player_evaluation[date(3i)]'

        end    

        it "should not create a new Player" do
          expect { click_button "Save Evaluation" }.not_to change(Player, :count)
        end
      
        it "should create a new Player Evaluation" do
          expect { click_button "Save Evaluation" }.to change(PlayerEvaluation, :count).by(1)
        end

        before { click_button "Save Evaluation" }

        it { should have_selector('div.alert.alert-success') }
        it { should have_title(player.last_name) }

        it { should have_content("Game") }
        it { should_not have_content("Practice") }

      end
    end

    describe "from Player index" do
      before { click_link "All Players" }
      before { click_link "Evaluate" }

      it { should have_title("Evaluate Player") }

      describe "with invalid information" do

        before { click_button "Save Evaluation" }

        it { should have_selector('div.alert.alert-error') }
        it { should have_title('Evaluate Player') }

      end

      describe "with valid information" do
        before do
          select 'Game',      from: 'player_evaluation[evaluation_type]'
          
          fill_in "League:",      with: "NHL"
          fill_in "Team:",        with: "Canadiens"
          
          select '2014',          from: 'player_evaluation[date(1i)]'
          select 'August',        from: 'player_evaluation[date(2i)]'
          select '8',             from: 'player_evaluation[date(3i)]'

        end
      
        it "should not create a new Player" do
          expect { click_button "Save Evaluation" }.not_to change(Player, :count)
        end
      
        it "should create a new Player Evaluation" do
          expect { click_button "Save Evaluation" }.to change(PlayerEvaluation, :count).by(1)
        end

        before { click_button "Save Evaluation" }

        it { should have_selector('div.alert.alert-succes') }
        it { should have_title('Evaluate Player') }

        it { should have_content("Game") }
        it { should_not have_content("Practice") }

      end

    end
  end

  describe "edit existing evaluation" do

    before { click_link "All Players" }

    before { click_link "View" }

    before { click_link "Edit Eval" }

    it { should have_title('Edit Evaluation') }

#    describe "with invalid information" do

# => default is valid; how to test for non-valid input

#    end

    describe "with valid information" do

      it { should have_title('Edit Evaluation') }

      before do
        select 'Post #9 Hockey Camp',      from: 'player_evaluation[evaluation_type]'
          
        fill_in "League:",      with: "NHL"
        fill_in "Team:",        with: "Canadiens"
          
        select '2014',          from: 'player_evaluation[date(1i)]'
        select 'August',        from: 'player_evaluation[date(2i)]'
        select '8',             from: 'player_evaluation[date(3i)]'

      end
      
      it "should not create a new Player" do
        expect { click_button "Save Evaluation" }.not_to change(Player, :count)
      end
      
      it "should create a new Player Evaluation" do
        expect { click_button "Save Evaluation" }.to change(PlayerEvaluation, :count).by(1)
      end

      before { click_button "Save Evaluation" }

      it { should have_selector('div.alert.alert-succes') }
      it { should have_title('Evaluate Player') }

      it { should have_content("Post #9 Hockey Camp") }
      it { should_not have_content("Practice") }

    end
  end

  describe "delete Player Evaluation" do
  
  end

  describe "delete Player" do
  
  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end