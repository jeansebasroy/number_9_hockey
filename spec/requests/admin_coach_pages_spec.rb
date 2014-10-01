describe "Admin Coach pages" do
	
  let(:admin_user) { FactoryGirl.create(:admin) }

  #let!(:coach) { FactoryGirl.create(:player) }
  #let!(:coach_evaluation) { FactoryGirl.create(:coach_evaluation, coach: coach) }

  let(:save) { "Save" }

	subject { page }

  before { visit signin_path }

  before do
   	fill_in "Email",    with: admin_user.email.upcase
    fill_in "Password", with: admin_user.password
    click_button "Sign In"
  end

  describe "create new Coach" do

    	
  end

  describe "edit existing Coach" do

    describe "from index" do

    end
    
    describe "from view" do

    end

  end

  describe "view Coaches" do

    describe "- All" do

    end

# =>     let!(:coach) { FactoryGirl.create(:coach) }  
      
# =>     before { click_link "All Coaches" }

# =>     it { should have_link('Evaluate') }
# =>     it { should have_link('View') }
# =>     it { should have_link('Edit') }      

  end

  describe "invite Coaches" do
    
    describe "from index" do
    end

    describe "from View" do
    end

  end

  describe "delete Coaches" do

    describe "from Index" do
    end

    describe "from View" do
    end
  end

  describe "admin sign out" do
   	before { click_link "Sign Out" }

   	it { should have_link('Sign In') }

  end
end