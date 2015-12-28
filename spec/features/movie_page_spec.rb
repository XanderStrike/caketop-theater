# frozen_string_literal: true
require 'rails_helper'

feature 'home page' do
  scenario 'user posts a comment' do
    page = MoviePage.new(create(:movie))
    page.submit_comment 'Stephen Spielberg', 'Hello this is a comment wow'

    expect(page).to have_text('Stephen Spielberg')
    expect(page).to have_text('Hello this is a comment wow')
  end

  scenario 'user pages through comments', js: true do
    movie = create(:movie)
    page = MoviePage.new(movie)
    page.submit_comment 'First Comment'
    10.times { create(:comment, movie: movie) }
    page.submit_comment 'Last Comment'

    page.comment_forward
    expect(page).to have_text('First Comment')

    page.comment_back
    expect(page).to have_text('Last Comment')
  end

  xscenario 'user retags movie', js: true do
    page = MoviePage.new(create(:movie))
    page.open_retag_modal
    page.retag_modal_search 'Jurassic Park'
    page.retag_modal_select 'Jurassic Park'
    expect(page).to have_content('Jurassic Park')
  end
end
