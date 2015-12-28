# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe '.get' do
    it 'should get the setting by its name' do
      setting = create(:setting, name: 'testsetting')
      expect(Setting.get('testsetting')).to eq(setting)
    end

    it 'should create a setting if one does not exist' do
      expect(Setting.get(:name).content).to eq('Caketop Theater')
    end
  end

  describe '.render' do
    context 'with boolean set to true' do
      it 'should render the contents' do
        setting = create(:setting, name: 'testsetting')
        expect(Setting.render('testsetting')).to eq('This is the contents of the setting!')
      end
    end

    context 'with boolean set to false' do
      it 'should not render the contents' do
        setting = create(:setting, name: 'testsetting', boolean: false)
        expect(Setting.render('testsetting')).to eq('')
      end
    end
  end

  describe '.update' do
    it 'should update any given setting' do
      setting = create(:setting, name: 'testsetting', boolean: false)
      Setting.update(setting: 'testsetting', content: 'somevalue')
      expect(Setting.get('testsetting').content).to eq('somevalue')
    end
  end
end
