# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Song Factory', type: :factory do
  it 'creates song with a title' do
    song = build(:song)
    expect(song.title).to_not eq(nil)
  end

  it 'has all the attributes from the model' do
    expect(attributes_for(:song)).to include(*(factory_attributes(Song) - [:album_id]))
  end

  it 'produces a valid model' do
    expect(build(:song)).to be_valid
  end
end
