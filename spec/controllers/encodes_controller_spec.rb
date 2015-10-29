require 'rails_helper'

RSpec.describe EncodesController, type: :controller do
  before(:each) do
    create_settings
  end

  describe 'POST find_movie' do
    # this has js shit ugh
  end

  describe 'GET retag' do
    it 'creates a new movie and assigns the encode to it'

    it 'destroys the movie if there are no more encodes attached'

    it 'adds the encode to a movie if one exists'
  end
end
