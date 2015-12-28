# frozen_string_literal: true
require 'rails_helper'

feature 'pages' do
  scenario 'user creates, edits, and deletes a page', js: true do
    page_object = SettingsPage.new
    page_object = page_object.create_page

    page_object.fill_out('Test Page', '# this is a header', false, false)
    expect(page.html).to include('<h1>this is a header</h1>')

    page_object.fill_out('Test Page', '*hello* ' * 10, false, false)
    page_object = page_object.create
    expect(page).to have_content('Test Page')
    expect(page).to have_selector('a', text: 'Test Page', count: 1)

    page_object = page_object.show_page('Test Page')
    expect(page).to have_content('hello ' * 10)
    expect(page.html).to include('<em>hello</em>')

    page_object = SettingsPage.new
    page_object = page_object.edit_page('Test Page')
    expect(page).to have_content('hello ' * 10)

    page_object.fill_out('Test Page', 'goodbye ' * 10, true, true)
    page_object = page_object.update
    expect(page).to have_selector('a', text: 'Test Page', count: 3)

    page_object.delete_page('Test Page')
    page.driver.browser.switch_to.alert.accept
    page_object = page_object.reload
    expect(page).to_not have_selector('a', text: 'Test Page')
  end
end
