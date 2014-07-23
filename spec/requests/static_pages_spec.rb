require 'rails_helper'

describe "Static pages" do

	let(:base_title) { "#9 Hockey" }
	# need to create a 'helper' file to define this for both "Static pages" & "User pages"
	
	subject { page }

	describe "Home page" do

		before { visit root_path }

		it { should have_title("#{base_title}") }
		it { should_not have_title('| Home') }
		it { should have_content("#9 Hockey") }
		
	end

	describe "Why #9? page" do

		before { visit why_9_path }

		it { should have_title("#{base_title} | Why #9?") }
		it { should have_content('Why #9?') }
		it { should have_content('For Players') }
		it { should have_content('For Coaches') }
		
	end

	describe "About Us page" do

		before { visit about_us_path }

		it { should have_title("#{base_title} | About Us") }
		it { should have_content('Who "we" are?') } 
		it { should have_content('Why "Invitation Only"?') }
		it { should have_content('Our Approach') }
		it { should have_content('About the Name') }
		it { should have_content('History of #9') }
		it { should have_content('Legacy of #9') }
		
	end

end
