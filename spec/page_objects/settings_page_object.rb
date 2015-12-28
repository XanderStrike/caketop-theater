# frozen_string_literal: true
class SettingsPage
  include Capybara::DSL

  def initialize
    visit '/settings'
  end

  def reload
    SettingsPage.new
  end

  def method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ /^set_(.*)$/
      within "##{Regexp.last_match(1)}_form" do
        fill_in :content, with: args.first
        choose (args.second ? 'Show' : 'Hide') unless args.second.nil?
        click_button 'Save'
      end
    else
      super
    end
  end

  def set_admin(username, password, enabled)
    within '#admin_form' do
      fill_in :content, with: username
      fill_in :admin_pass, with: password
      choose (enabled ? 'Yes' : 'No')
      click_button 'Save'
    end
  end

  def create_page
    click_link '+ New Page'
    EditPage.new
  end

  def edit_page(name)
    within '#pages_table' do
      find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", text: 'Edit').click
    end
    EditPage.new
  end

  def show_page(name)
    within '#pages_table' do
      click_link name
    end
    ShowPage.new
  end

  def delete_page(name)
    within '#pages_table' do
      find(:xpath, "//tr[td[contains(.,'#{name}')]]/td/a", text: 'Delete').click
    end
  end
end
