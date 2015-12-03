# frozen_string_literal: true
class EditPage
  include Capybara::DSL

  def initialize
  end

  def fill_out(name, content, header, footer)
    fill_in :page_name, with: name
    fill_in :page_text, with: content
    check 'Show in navbar?' if header
    check 'Show in footer?' if footer
  end

  def create
    click_button 'Create Page'
    SettingsPage.new
  end

  def update
    click_button 'Update Page'
    SettingsPage.new
  end
end

class ShowPage
  include Capybara::DSL

  def initialize
  end
end
