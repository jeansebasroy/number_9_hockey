require 'rails_helper'

describe "User pages" do

	let(:base_title) { "#9 Hockey" }
	# need to create a 'helper' file to define this for both "Static pages" & "User pages"

	subject { page }

	describe "login page" do

		before { visit login_path }

		it { should have_title("#{base_title} | Login") }
		it { should have_content("Login") }
		
	end
end
