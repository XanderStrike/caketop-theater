# frozen_string_literal: true
class AboutPage
  include Capybara::DSL

  def initialize
    visit '/about'
  end
end
