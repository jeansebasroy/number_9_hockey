require 'rails_helper'

describe "Static pages" do

	describe "Home page" do

		it "should have the right title" do
			visit '/static_pages/home'
			expect(page).to have_title("#9 Hockey | Home")
		end

		it "should have the content '#9 Hockey'" do
			visit '/static_pages/home'
			expect(page).to have_content('#9 Hockey')
		end

	end

	describe "Why #9? page" do

		it "should have the right title" do
			visit '/static_pages/why_9'
			expect(page).to have_title("#9 Hockey | Why #9?")
		end

		it "should have the content 'Why #9?'" do
			visit '/static_pages/why_9'
			expect(page).to have_content('Why #9?')
		end

		it "should have the content 'For Players'" do
			visit '/static_pages/why_9'
			expect(page).to have_content('For Players')
		end

		it "should have the content 'For Coaches'" do
			visit '/static_pages/why_9'
			expect(page).to have_content('For Coaches')
		end

		
	end

	describe "About Us page" do

		it "should have the right title" do
			visit '/static_pages/about_us'
			expect(page).to have_title("#9 Hockey | About Us")
		end

		it "should have the content 'Who 'we' are?'" do
			visit '/static_pages/about_us'
			expect(page).to have_content('Who "we" are?')
		end

		it "should have the content 'Why 'Invitation Only'?'" do
			visit '/static_pages/about_us'
			expect(page).to have_content('Why "Invitation Only"?')
		end
		
		it "should have the content 'Our Approach'" do
			visit '/static_pages/about_us'
			expect(page).to have_content('Our Approach')
		end

		it "should have the content 'About the Name'" do
			visit '/static_pages/about_us'
			expect(page).to have_content('About the Name')
		end

		it "should have the content 'History of #9'" do
			visit '/static_pages/about_us'
			expect(page).to have_content('History of #9')
		end

		it "should have the content 'Legacy of #9" do
			visit '/static_pages/about_us'
			expect(page).to have_content('Legacy of #9')
		end

	end

end
