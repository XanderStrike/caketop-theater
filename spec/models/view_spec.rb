require 'rails_helper'

RSpec.describe View, type: :model do
  describe '#hour' do
    it 'returns the hour the view took place in' do
      view = View.new(created_at: Time.now.end_of_day)
      expect(view.hour).to eq('23')
    end
  end

  describe '#day_of_week' do
    it 'returns the day of the week of that view' do
      view = View.new(created_at: Time.now.beginning_of_week)
      expect(view.day_of_week).to eq('1')
    end
  end
end
