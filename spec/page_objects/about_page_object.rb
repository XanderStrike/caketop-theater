class AboutPage
	include Capybara::DSL

	def initialize
		visit '/about'
	end
end
