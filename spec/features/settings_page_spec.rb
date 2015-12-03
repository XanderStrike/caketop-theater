# frozen_string_literal: true
# -*- coding: utf-8 -*-
require 'rails_helper'

feature 'settings page' do
  scenario 'user changes the site name', js: true do
    page = SettingsPage.new
    page.set_name 'Testtop Theater'
    expect(has_button?('Save ✓')).to equal(true)

    page = HomePage.new
    expect(page).to have_content('Testtop Theater')
  end

  scenario 'user changes the about page', js: true do
    page = SettingsPage.new
    page.set_about 'Test please ignore'
    expect(has_button?('Save ✓')).to equal(true)

    page = AboutPage.new
    expect(page).to have_content('Test please ignore')
  end

  scenario 'user password protects the settings page' do
    page = SettingsPage.new
    page.set_admin 'admin', 'password', true

    basic_auth('admin', 'wrongpassword')
    page = page.reload
    expect(page).to have_content('Access denied')

    basic_auth('admin', 'password')
    page = page.reload
    expect(page).to have_content('Password protect this page?')

    page.set_admin '', '', false
    basic_auth('', '')
    page = page.reload
    expect(page).to have_content('Password protect this page?')
  end

  scenario 'user changes the banner area', js: true do
    page = SettingsPage.new
    page.set_banner 'This is the banner', false
    expect(has_button?('Save ✓')).to equal(true)
    page = HomePage.new
    expect(page).to_not have_content('This is the banner')

    page = SettingsPage.new
    page.set_banner 'This is the banner', true
    expect(has_button?('Save ✓')).to equal(true)
    page = HomePage.new
    expect(page).to have_content('This is the banner')
  end

  scenario 'user changes the footer', js: true do
    page = SettingsPage.new
    page.set_footer 'This is the footer', false
    expect(has_button?('Save ✓')).to equal(true)
    page = HomePage.new
    expect(page).to_not have_content('This is the footer')

    page = SettingsPage.new
    page.set_footer 'This is the footer', true
    expect(has_button?('Save ✓')).to equal(true)
    page = HomePage.new
    expect(page).to have_content('This is the footer')
  end

  scenario 'user changes the sub-url', js: true do
    page = SettingsPage.new
    page.set_url '/theater'
    expect(has_button?('Save ✓')).to equal(true)
    page = HomePage.new
    expect(page.home_link[:href]).to have_content('/theater')
  end

  scenario 'user changes movie dir setting', js: true do
    page = SettingsPage.new
    page.set_movie_dir '/srv/movies'
    expect(has_button?('Save ✓')).to equal(true)
    expect(Setting.get(:movie_dir).content).to eq('/srv/movies')
  end

  scenario 'user changes tv dir setting', js: true do
    page = SettingsPage.new
    page.set_tv_dir '/srv/tv'
    expect(has_button?('Save ✓')).to equal(true)
    expect(Setting.get(:tv_dir).content).to eq('/srv/tv')
  end

  scenario 'user changes music dir setting', js: true do
    page = SettingsPage.new
    page.set_music_dir '/srv/music'
    expect(has_button?('Save ✓')).to equal(true)
    expect(Setting.get(:music_dir).content).to eq('/srv/music')
  end
end
