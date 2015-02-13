class HomePage
	include Capybara::DSL

	def initialize
		visit '/'
	end

	def submit_comment(name='Test', body='Default Body')
		fill_in "comment_name", with: name
		fill_in "comment_body", with: body
		click_button "Submit"
	end

	def comment_forward
		click_link "Next ›"
	end

	def comment_back
		click_link '‹ Prev'
	end

	def search_television(q='')

	end
end
