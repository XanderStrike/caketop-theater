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
		click_link "Next"
	end

	def comment_back
		click_link 'Prev'
	end

	def search_tv q=''
		fill_in 'tv-search', with: q
		find_field('tv-search').native.send_key(:enter)
	end

	def search_movies q=''
		fill_in 'movie-search', with: q
		find_field('movie-search').native.send_key(:enter)
	end

	def search_music q=''
		fill_in 'music-search', with: q
		find_field('music-search').native.send_key(:enter)
	end

	def home_link
		find_link('Home')
	end
end
