require "rails_helper"

feature "home page" do
	scenario "user visits the home page" do
		page = HomePage.new
		expect(page).to have_text("Chose your adventure...")
	end

	scenario "user posts a comment" do
		page = HomePage.new
		page.submit_comment "Testy McTesterson", "Hello this is a comment wow"

		expect(page).to have_text("Testy McTesterson")
		expect(page).to have_text("Hello this is a comment wow")
	end

	scenario "user pages through comments" do
		page = HomePage.new
		page.submit_comment 'First Comment'
		15.times {|n| page.submit_comment}
		page.submit_comment 'Last Comment'

		page.comment_forward
		expect(page).to have_text('First Comment')

		page.comment_back
		expect(page).to have_text('Last Comment')
	end


end
