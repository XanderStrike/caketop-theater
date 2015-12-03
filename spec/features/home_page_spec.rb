# frozen_string_literal: true
require 'rails_helper'

feature 'home page' do
  scenario 'user visits the home page' do
    page = HomePage.new
    expect(page).to have_text('Chose your adventure...')
  end

  scenario 'user posts a comment' do
    page = HomePage.new
    page.submit_comment 'Stephen Spielberg', 'Hello this is a comment wow'

    expect(page).to have_text('Stephen Spielberg')
    expect(page).to have_text('Hello this is a comment wow')
  end

  scenario 'user pages through comments', js: true do
    page = HomePage.new
    page.submit_comment 'First Comment'
    15.times { |_n| page.submit_comment }
    page.submit_comment 'Last Comment'

    page.comment_forward
    expect(page).to have_text('First Comment')

    page.comment_back
    expect(page).to have_text('Last Comment')
  end

  scenario 'user searches for tv show', js: true do
    page = HomePage.new
    create(:show, name: 'Friends')
    create_list(:show, 20)

    page.search_tv 'friend'
    expect(page).to have_content('Friends')
  end

  scenario 'user searches for a movie', js: true do
    page = HomePage.new
    create(:movie, title: 'The Curious Cake of Benjamin Button')
    create_list(:movie, 20)

    page.search_movies 'curious'
    expect(page).to have_content('The Curious Cake of Benjamin Button')
  end
end
