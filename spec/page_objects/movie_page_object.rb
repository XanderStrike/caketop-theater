class MoviePage
	include Capybara::DSL

	def initialize movie
		visit "/movies/#{movie.id}"
	end

	def submit_comment(name='Test', body='Default Body')
		fill_in "comment_name", with: name
		fill_in "comment_body", with: body
		click_button "Submit"
	end

	def comment_forward
		click_link "Next"
	end

	def comment_back
		click_link 'Prev'
	end

	def open_retag_modal
		click_link "Encodes"
		all(".retag-link").first.click
	end

	def retag_modal_search query
		fill_in :title, with: query
		find_field('title').native.send_key(:enter)
	end

	def retag_modal_select link
		click_link link
	end
end
